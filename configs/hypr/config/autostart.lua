--# selene: allow(undefined_variable)
--[[
    Autostarting programs
    https://wiki.hypr.land/Configuring/Basics/Autostart/
]]

local programs = require("config.programs")
local uwsm = require("Util.uwsm")

hl.on("hyprland.start", function()
    hl.exec_cmd(uwsm.wrap("awww-daemon") .. " &")
    hl.exec_cmd("sh -c 'awww query && awww restore' &")
    hl.exec_cmd(uwsm.wrap("waybar") .. " &")
    hl.exec_cmd(uwsm.wrap("xembedsniproxy") .. " &")
    hl.exec_cmd(uwsm.wrap("swayosd-server") .. " &")
    hl.exec_cmd(uwsm.wrap("otd-daemon") .. " &")
    hl.exec_cmd(uwsm.wrap("hypridle") .. " &")

    hl.exec_cmd("hyprpm reload -n &")
    hl.exec_cmd(uwsm.wrap("udiskie --notify") .. " &")
    hl.exec_cmd(uwsm.wrap("kbuildsycoca6") .. " &")
    hl.exec_cmd(uwsm.wrap(programs.terminal) .. " &")

    hl.exec_cmd("uwsm finalize")
end)
