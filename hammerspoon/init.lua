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

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()