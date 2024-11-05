local colors = vim.g.material_colorscheme_map
local style = vim.g.material_theme_style
local notify = vim.notify

-- If material colors are not found, defaults to lualine material theme
if not colors then
	local msg = "material colors not loaded. Defaults to lualine material theme"
	notify(msg, "warn", { title = "material.vim" })
	return require("lualine.themes.material")
end

local middle = style == "lighter" and colors.fg or colors.bg
local b_bg = colors.line_numbers

return {
	normal = {
		a = { fg = colors.cyan.gui, bg = colors.bg.gui },
		b = { fg = colors.fg.gui, bg = colors.bg.gui },
		c = { fg = colors.invisibles.gui, bg = colors.bg.gui },
	},
	insert = {
		a = { fg = colors.purple.gui, bg = colors.bg.gui },
		b = { fg = colors.fg.gui, bg = colors.bg.gui },
	},
	visual = {
		a = { fg = colors.yellow.gui, bg = colors.bg.gui },
		b = { fg = colors.fg.gui, bg = colors.bg.gui },
	},
	replace = {
		a = { fg = colors.green.gui, bg = colors.bg.gui },
		b = { fg = colors.fg.gui, bg = colors.bg.gui },
	},
	inactive = {
		a = { fg = colors.fg.gui, bg = colors.bg.gui, gui = "bold" },
		b = { fg = colors.fg.gui, bg = colors.bg.gui },
		c = { fg = colors.fg.gui, bg = colors.bg.gui },
	},
}
