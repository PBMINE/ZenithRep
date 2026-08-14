--# selene: allow(undefined_variable)
--[[
    Input devices and gestures
    https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
    https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
]]

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "elan901c:00-04f3:2a3b",
    transform = 0,
})
