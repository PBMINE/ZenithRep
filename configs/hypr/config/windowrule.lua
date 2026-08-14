--# selene: allow(undefined_variable)
require("config.animation")
hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({ 
  match = { class = "fl64.exe" }, 
  float = true, 
  no_blur = true, 
  no_shadow = true, 
})


hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = {
		class = "xwaylandvideobridge",
	},
	no_initial_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = { 1, 1 },
	opacity = 0.0,
	no_focus = true,
})

hl.window_rule({
	name = "vinegarNoBlur",
	match = {
		class = "vinegar"
	},
	no_blur = true
})

hl.window_rule({
	name = "LineNoBlur",
	match = {
		class = "^(line.exe)",
	},
	no_blur = true,
})


hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run",
	},
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "waypaper-float",
	match = {
		class = "^(waypaper)$",
	},
	float = 1,
	size = "1000 600",
	center = true,
})

hl.window_rule({
	match = {
		xwayland = true,
		title = "^$",
		class = "^$",
		initial_class = "^$",
		initial_title = "^$",
	},
	opacity = "0.0",
	float = true,
	no_blur = true,
})

hl.window_rule({
	match = { class = "OpenTabletDriver.UX" },
	float = true,
})

hl.window_rule({ no_initial_focus = true, match = { xwayland = true } })
