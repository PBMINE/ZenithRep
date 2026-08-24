--# selene: allow(undefined_variable)
--[[
    Keybinds
    https://wiki.hypr.land/Configuring/Basics/Binds/
    https://wiki.hypr.land/Configuring/Basics/Dispatchers/
]]

local _programs = require("config.programs")
local uwsm = require("Util.uwsm")
local modkeys = "SUPER"

-- Core binds
hl.bind(modkeys .. " + Q", hl.dsp.exec_cmd(uwsm.wrap(_programs.terminal)))
hl.bind(modkeys .. " + C", hl.dsp.window.close())

-- Session management
if uwsm.is_active then
    hl.bind(modkeys .. " + M", hl.dsp.exec_cmd("uwsm stop"))
else
    hl.bind(modkeys .. " + M", hl.dsp.exit())
end

hl.bind(modkeys .. " + E", hl.dsp.exec_cmd(uwsm.wrap(_programs.fileManager)))

-- Wallpaper picker with Rofi + Matugen
hl.bind(modkeys .. " + W", hl.dsp.exec_cmd(uwsm.wrap("/home/pbmine/.zenithrep/configs/rofi/scripts/wallpaper-picker.sh")))

-- OpenTabletDriver toggle
hl.bind("code:191", function()
    local windows = hl.get_windows()
    for _, win in ipairs(windows) do
        if win.class == "OpenTabletDriver.UX" then
            hl.dispatch(hl.dsp.window.close({ window = "address:" .. win.address }))
            return
        end
    end
    hl.dispatch(hl.dsp.exec_cmd(uwsm.wrap("otd-gui")))
end)

hl.bind(modkeys .. " + V", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

    local floatwindows = hl.get_active_window()

    if floatwindows ~= nil and floatwindows.floating then
        hl.dispatch(hl.dsp.window.resize({ x = 850, y = 600, relative = false }))
        hl.dispatch(hl.dsp.window.center())
    end
end)

hl.bind(modkeys .. " + R", hl.dsp.exec_cmd(uwsm.wrap(_programs.launcher)))
hl.bind(modkeys .. " + P", hl.dsp.window.pseudo())
hl.bind(modkeys .. " + J", hl.dsp.layout("togglesplit"))

-- Focus movement
hl.bind(modkeys .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(modkeys .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(modkeys .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(modkeys .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(modkeys .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(modkeys .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace
hl.bind(modkeys .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(modkeys .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse binds
hl.bind(modkeys .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(modkeys .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(modkeys .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(modkeys .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(uwsm.wrap("swayosd-client --output-volume raise --max-volume 100")), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(uwsm.wrap("swayosd-client --output-volume lower")), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(uwsm.wrap("swayosd-client --output-volume mute-toggle")), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(uwsm.wrap("swayosd-client --brightness +5")), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(uwsm.wrap("swayosd-client --brightness -5")), { locked = true, repeating = true })

hl.bind("Print", hl.dsp.exec_cmd(uwsm.wrap("flameshot gui")))

-- Media control
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(uwsm.wrap("playerctl next")), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(uwsm.wrap("playerctl play-pause")), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(uwsm.wrap("playerctl play-pause")), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(uwsm.wrap("playerctl previous")), { locked = true })

-- Lid switch
hl.bind("switch:on:Lid", hl.dsp.exec_cmd(uwsm.wrap("hyprlock & systemctl suspend")), { locked = true })
