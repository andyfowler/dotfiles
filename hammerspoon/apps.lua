local eventtap = hs.eventtap
local eventTypes = hs.eventtap.event.types
local message = require('status-message')

local log = hs.logger.new('supermode.lua', 'debug')

statusMessage = message.new('Apps!')

k = hs.hotkey.modal.new('ctrl', 'a')

closeAllTheThings = function()
    k:exit()
end

function k:entered()
    overlayKeyboard = eventtap.new({ eventTypes.keyDown }, function(event)
        local keyPressed = hs.keycodes.map[event:getKeyCode()]
        local modifiersPressed = event:getFlags()

        -- log.d('Event keyboard detected:', hs.inspect(modifiersPressed), keyPressed )

        -- Application launchers
        local applicationLaunchers = {
            ['1'] = 'Google Chrome',
            ['2'] = 'PhpStorm-EAP',
            ['3'] = 'Terminal',
            ['4'] = 'Spotify',
            ['9'] = 'Mail',
            ['0'] = 'Slack',
        }
        if applicationLaunchers[keyPressed] then
            hs.application.launchOrFocus(applicationLaunchers[keyPressed])
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
            log.d('windowkeys:', hs.inspect(keyPressed ))
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