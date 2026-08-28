--# selene: allow(undefined_variable)
--[[
    Layer shell rules
    https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules
]]

hl.layer_rule({ blur = true, match = { namespace = "rofi" } })
hl.layer_rule({ animation = "popin", match = { namespace = "rofi" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "rofi" } })

hl.layer_rule({ blur = true, match = { namespace = "waybar" } })
hl.layer_rule({ animation = "slide bottom", match = { namespace = "waybar" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "waybar" } })
hl.layer_rule({ blur_popups = true, match = { namespace = "waybar" } })

hl.layer_rule({ blur = true, match = { namespace = "logout_dialog" } })
hl.layer_rule({ animation = "fade", match = { namespace = "logout_dialog" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "logout_dialog" } })

hl.layer_rule({ blur = true, match = { namespace = "swaync-notification-window" } })
hl.layer_rule({ ignore_alpha = 0.35, match = { namespace = "swaync-notification-window" } })
hl.layer_rule({ animation = "slide bottom", match = { namespace = "swaync-notification-window" } })

hl.layer_rule({ blur = true, match = { namespace = "swayosd" } })
hl.layer_rule({ animation = "slide bottom", match = { namespace = "swayosd" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "swayosd" } })

hl.layer_rule({ blur = true, match = { namespace = "swaync-control-center" } })
hl.layer_rule({ ignore_alpha = 0.35, match = { namespace = "swaync-control-center" } })
hl.layer_rule({ animation = "slide right", match = { namespace = "swaync-control-center" } })

hl.layer_rule({ blur = true, match = { namespace = "quickshell" } })
hl.layer_rule({ animation = "slide bottom", match = { namespace = "quickshell" } })
hl.layer_rule({ ignore_alpha = 0, match = { namespace = "quickshell" } })
hl.layer_rule({ blur_popups = true, match = { namespace = "quickshell" } })
