--# selene: allow(undefined_variable)
--[[
    Monitor configuration
    https://wiki.hypr.land/Configuring/Basics/Monitors/
]]

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto",
    scale = "1",
    transform = 0,
})

hl.monitor({
    output = "DP-1",
    mode = "preferred",
    position = "auto",
    scale = "1",
    mirror = "eDP-1",
})

hl.monitor({
    output = "DP-2",
    mode = "preferred",
    position = "auto",
    scale = "1",
    mirror = "eDP-1",
})
