local eventtap = hs.eventtap
local eventTypes = hs.eventtap.event.types
local message = require('status-message')

local log = hs.logger.new('supermode.lua', 'debug')

statusMessage = message.new('Apps!')

k = hs.hotkey.modal.new('ctrl', 's')

myApps = {
    ['1'] = 'Google Chrome',
    -- ['2'] = 'Sublime Text',
    ['2'] = 'Visual Studio Code',
    ['3'] = 'Xcode',
    ['4'] = 'Terminal',
    ['5'] = 'Spotify',
    ['6'] = 'Finder',
    ['7'] = 'zoom.us',
    ['9'] = 'Mail',
    ['0'] = 'Slack',
    ['19'] = 'Simulator',
}

hs.hotkey.bind({}, 'f1', function() hs.application.launchOrFocus(myApps['1']) end)
hs.hotkey.bind({}, 'f2', function() hs.application.launchOrFocus(myApps['2']) end)
hs.hotkey.bind({}, 'f3', function() hs.application.launchOrFocus(myApps['3']) end)
hs.hotkey.bind({}, 'f4', function() hs.application.launchOrFocus(myApps['4']) end)
hs.hotkey.bind({}, 'f5', function() hs.application.launchOrFocus(myApps['5']) end)
hs.hotkey.bind({}, 'f6', function() hs.application.launchOrFocus(myApps['6']) end)
hs.hotkey.bind({}, 'f7', function() hs.application.launchOrFocus(myApps['7']) end)
hs.hotkey.bind({}, 'f9', function() hs.application.launchOrFocus(myApps['9']) end)
hs.hotkey.bind({}, 'f10', function() hs.application.launchOrFocus(myApps['0']) end)
hs.hotkey.bind({}, 'f19', function() hs.application.launchOrFocus(myApps['19']) end)

closeAllTheThings = function()
    k:exit()
end

function k:entered()
    overlayKeyboard = eventtap.new({ eventTypes.keyDown }, function(event)
        local keyPressed = hs.keycodes.map[event:getKeyCode()]
        local modifiersPressed = event:getFlags()

        -- log.d('Event keyboard detected:', hs.inspect(modifiersPressed), keyPressed )

        -- Application launchers
        if myApps[keyPressed] then
            hs.application.launchOrFocus(myApps[keyPressed])
            closeAllTheThings()
            return true
        end

        local quitTriggers = {
            {mod='', key='escape'},
            {mod='', key='q'},
            {mod='ctrl', key='s'},
            {mod='ctrl', key='['},
        }
        for k,v in pairs(quitTriggers) do
            if v.key == keyPressed then
                if not (v.mod == nil or v.mod == '') then
                    if modifiersPressed[v.mod] then
                        closeAllTheThings()
                        return true
                    end
                else
                    closeAllTheThings()
                    return true
                end
            end
        end

        local replacements = {
            h = 'left',
            j = 'down',
            k = 'up',
            l = 'right',
        }
        local keystroke = replacements[keyPressed]
        if keystroke then
            event:setKeyCode(hs.keycodes.map[keystroke])
            return false
        end

        -- window sizing
        local windowKeys = {
            z = 1,
            x = 1,
            m = 1,
            f = 1,
        }
        if windowKeys[keyPressed] then
            -- log.d('windowkeys:', hs.inspect(keyPressed ))
            hs.window.animationDuration = 0

            local win = hs.window.focusedWindow()
            local f = win:frame()
            local screen = win:screen()
            local max = screen:frame()

            -- half-left
            if keyPressed == 'z' then
                f.x = max.x
                f.y = max.y
                f.w = max.w * 0.5
                f.h = max.h
            -- .6 -left
            elseif keyPressed == 'x' then
                f.x = max.x
                f.y = max.y
                f.w = max.w * 0.67
                f.h = max.h
            elseif keyPressed == 'm' then
                f.x = max.x + (max.w * 0.5)
                f.y = max.y
                f.w = max.w * 0.5
                f.h = max.h
            elseif keyPressed == 'f' then
                f.x = max.x
                f.y = max.y
                f.w = max.w
                f.h = max.h
            end

            win:setFrame(f)
            closeAllTheThings()
            return true
        end

        -- see how this feels: if a key is hit which is not defined in this mode
        -- we break out of SD mode and carry on
        closeAllTheThings()
        return false
    end):start()

    statusMessage:show()
end

function k:exited()
    overlayKeyboard:stop()
    statusMessage:hide()
end