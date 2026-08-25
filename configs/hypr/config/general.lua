--# selene: allow(undefined_variable)
--[[
    General look and feel
    https://wiki.hypr.land/Configuring/Basics/Variables/
    https://wiki.hypr.land/Configuring/Basics/Variables/#general
    https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
    https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    https://wiki.hypr.land/Configuring/Basics/Variables/#input
    https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
]]
local colors = require("colors")

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = { top = 10, right = 10, bottom = 5, left = 10 },
        border_size = 4,
        col = {
            active_border = colors.matchsurfacelow,
            inactive_border = colors.matchsurfacelow,
        },
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
        snap = {
            enabled = true,
            window_gap = 10,
            monitor_gap = 10,
            border_overlap = false,
            respect_gaps = true,
        },
    },
    decoration = {
        rounding = 0,
        rounding_power = 10,
        active_opacity = 1,
        inactive_opacity = 1,
        dim_modal = true,
        dim_inactive = false,
        dim_strength = 0.1,
        shadow = {
            enabled = false,
        },
        blur = {
            enabled = true,
            size = 16,
            passes = 2,
            ignore_opacity = true,
            noise = 0.050,
            vibrancy = 0.1696,
        },
    },
    render = {
        direct_scanout = 1,
        new_render_scheduling = true,
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        animate_mouse_windowdragging = true,
    },
    input = {
        kb_layout = "us,th",
        kb_options = "grp:win_space_toggle",
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },


})
