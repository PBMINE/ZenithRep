--# selene: allow(undefined_variable)
--[[
    Simple Logging/Notify module for hyprland lua
    by PBMINE
]]

local logger = {}

local icon_set = {
	warning = 0,
	info = 1,
	tips = 2,
	error = 3,
	mistake = 4,
	ok = 5,
}

function logger:log(itext, Sec, icon, fontsize)
	local milisecond = Sec * 1000
	local realicon = icon_set[icon] or 6
	local statustext = string.upper(icon) or "UNK"

	hl.notification.create({
		text = string.format("[%s] %s", statustext, tostring(itext)),
		duration = milisecond,
		icon = realicon,
		font_size = fontsize,
	})
end

return logger
