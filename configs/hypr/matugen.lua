--# selene: allow(undefined_variable)
--[[
    Matugen integration for Hyprland Lua
    This script runs matugen to generate colors and then reloads the config.
]]

local logger = require("Util.logger")

local M = {}

function M.generate(image_path)
    if not image_path then
        logger:log("No image path provided for Matugen!", 5, "error")
        return
    end

    logger:log("Generating colors with Matugen...", 3, "info")
    
    -- Matugen command to generate hyprland colors and lua colors
    -- We assume matugen templates are set up to write to hypr/colors.conf and hypr/colors.lua
    local cmd = string.format("matugen image %s", image_path)
    
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    
    logger:log("Matugen colors updated!", 5, "ok")
    
    -- Hyprland Lua will automatically reload if it detects changes to required files
    -- but we can trigger a manual reload if needed via hyprctl
    os.execute("hyprctl reload")
end

return M
