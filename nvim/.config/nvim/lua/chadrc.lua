-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

local pwdLine = ""
local handle = io.popen("pwd")
if handle ~= nil then
	local pwd = handle:read()
	handle:close()
	pwdLine = pwd
	local spaceToFill = (50 - string.len(pwd))
	for i = 0, spaceToFill do
		if i % 2 == 0 then
			pwdLine = pwdLine .. " "
		else
			pwdLine = " " .. pwdLine
		end
	end
end

local banner = require("configs/banners/yuanshen")
table.insert(banner, pwdLine)

M.nvdash = {
	load_on_startup = true,
	header = banner,
}
M.ui = {
	tabufline = {
		lazyload = false,
	},
}

return M
