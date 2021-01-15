-- most of this config copped from github.com/flav/hammerspoon/

-- Use Control+` to reload Hammerspoon config
-- hs.hotkey.bind({'ctrl'}, '`', nil, function()
--     hs.reload()
-- end)

-- app switcher / window sizer
require('apps')

-- use ctrl + [ as escape everywhere in the os
hs.hotkey.bind("ctrl", "[", function()
    hs.eventtap.keyStroke(nil, "escape")
    return true
end)

-- http://thume.ca/2016/07/16/advanced-hackery-with-the-hammerspoon-window-manager/
--local hints = require 'hs.hints'
--hs.hotkey.bind({'ctrl'}, 'y', nil, function()
--    hints.windowHints()
--end)

hs.eventtap.new({ hs.eventtap.event.types.NSSystemDefined }, function(event)
    -- http://www.hammerspoon.org/docs/hs.eventtap.event.html#systemKey
    flags = event:getFlags()
    event = event:systemKey()
    -- http://stackoverflow.com/a/1252776/1521064
    local next = next
    -- Check empty table
    if next(event) then
        if event.key == 'EJECT' and event.down and flags.fn then
            print('This is my EJECT key event')
            hs.osascript.applescript([[
                set zoomInMeeting to false
                tell application "System Events"
                    set myList to name of windows of (processes whose name is "zoom.us")
                end tell
                set theWindowList to my subListsToOneList(myList) --  Flattening a list of lists
                on subListsToOneList(x)
                    set newL to {}
                    repeat with i in x
                        set newL to newL & i
                    end repeat
                    set theWindowList to newL
                end subListsToOneList

                if theWindowList contains "Zoom Meeting" then
                    set zoomInMeeting to true
                end if

                if zoomInMeeting is true then
                    tell application "zoom.us"
                        activate
                        tell application "System Events"
                            keystroke "w" using {command down}
                        end tell
                        try
                            tell application "System Events"
                                tell front window of (first application process whose frontmost is true)
                                    click button 1
                                end tell
                            end tell
                        end try
                    end tell
                    return
                end if
            ]])
        end
    end
end):start()

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
