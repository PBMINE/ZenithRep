--# selene: allow(undefined_variable)
--[[
    Animation curves and layers
    https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
]]

-- Cubic bezier curves (kept for specific uses)
hl.curve("easeOutExpo",       { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

-- Spring curves for natural-feeling motion
hl.curve("springSnappy",  { type = "spring", mass = 1, stiffness = 500, dampening = 42 })
hl.curve("springSmooth",  { type = "spring", mass = 1, stiffness = 350, dampening = 37 })
hl.curve("springSoft",    { type = "spring", mass = 1, stiffness = 180, dampening = 30 })
hl.curve("springBouncy",  { type = "spring", mass = 1, stiffness = 200, dampening = 20 })

hl.animation({ leaf = "global",             enabled = true, speed = 8,   bezier = "default" })
hl.animation({ leaf = "border",             enabled = true, speed = 2.0, spring = "springSnappy" })
hl.animation({ leaf = "borderangle",        enabled = false, speed = 6,   bezier = "easeOutExpo", style = "loop" })
hl.animation({ leaf = "windows",            enabled = true, speed = 2.5, spring = "springSnappy" })
hl.animation({ leaf = "windowsIn",          enabled = true, speed = 2.5, spring = "springSmooth", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",         enabled = true, speed = 3.5, spring = "springSmooth", style = "popin 80%" })
hl.animation({ leaf = "windowsMove",        enabled = true, speed = 2.5, spring = "springSnappy" })
hl.animation({ leaf = "fade",               enabled = true, speed = 2.0, spring = "springSoft" })
hl.animation({ leaf = "fadeIn",             enabled = true, speed = 2.5, spring = "springSoft" })
hl.animation({ leaf = "fadeOut",            enabled = true, speed = 3.5, spring = "springSoft" })
hl.animation({ leaf = "fadeSwitch",         enabled = true, speed = 2.0, spring = "springSnappy" })
hl.animation({ leaf = "fadeShadow",         enabled = true, speed = 2.0, spring = "springSnappy" })
hl.animation({ leaf = "fadeDim",            enabled = true, speed = 2.5, spring = "springSmooth" })
hl.animation({ leaf = "layers",             enabled = true, speed = 2.5, spring = "springSmooth" })
hl.animation({ leaf = "layersIn",           enabled = true, speed = 2.5, spring = "springSmooth", style = "slide" })
hl.animation({ leaf = "layersOut",          enabled = true, speed = 3.5, spring = "springSmooth", style = "slide" })
hl.animation({ leaf = "fadeLayersIn",       enabled = true, speed = 2.5, spring = "springSoft" })
hl.animation({ leaf = "fadeLayersOut",      enabled = true, speed = 3.5, spring = "springSoft" })
hl.animation({ leaf = "fadePopups",         enabled = true, speed = 2.0, spring = "springSoft" })
hl.animation({ leaf = "fadePopupsIn",       enabled = true, speed = 2.5, spring = "springSoft" })
hl.animation({ leaf = "fadePopupsOut",      enabled = true, speed = 3.5, spring = "springSoft" })
hl.animation({ leaf = "workspaces",         enabled = true, speed = 2.5, spring = "springSmooth", style = "slide" })
hl.animation({ leaf = "workspacesIn",       enabled = true, speed = 2.5, spring = "springSmooth", style = "slide" })
hl.animation({ leaf = "workspacesOut",      enabled = true, speed = 2.0, spring = "springSmooth", style = "slide" })
hl.animation({ leaf = "zoomFactor",         enabled = true, speed = 4,   spring = "springSnappy" })
hl.animation({ leaf = "specialWorkspace",   enabled = true, speed = 4,   spring = "springSmooth" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 4,   spring = "springSmooth", style = "slidefade bottom" })
hl.animation({ leaf = "specialWorkspaceOut",enabled = true, speed = 4,   spring = "springSmooth", style = "slidefade top" })
hl.animation({ leaf = "monitorAdded",       enabled = true, speed = 3,   spring = "springBouncy" })
