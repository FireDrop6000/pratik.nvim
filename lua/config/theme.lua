local colors = require("config.colors")
local set_hl = vim.api.nvim_set_hl

require("base16-colorscheme").setup(colors)

-- Some custom highlight definitions
set_hl(0, "CursorLineNr", { fg = colors.base05 })
set_hl(0, "VertSplit", { fg = colors.base08 })
set_hl(0, "WinSeparator", { fg = colors.base02 })
set_hl(0, "LspSignatureActiveParameter", { bg = colors.base02 })
set_hl(0, "NvimTreeNormal", { bg = colors.nvim_tree.bg })
set_hl(0, "NvimTreeWindowPicker", { bg = colors.nvim_tree.picker_bg })
set_hl(0, "PmenuSbar", { bg = colors.base01 })
set_hl(0, "PmenuThumb", { bg = colors.base03 })
set_hl(0, "DiagnosticWarn", { fg = colors.base0A })
set_hl(0, "Visual", { bg = colors.base02 })
set_hl(0, "NoiceVirtualText", { fg = colors.base0A })
set_hl(0, "IlluminatedWordText", { bg = colors.base02, underline = false })
set_hl(0, "IlluminatedWordRead", { bg = colors.base02, underline = false })
set_hl(0, "IlluminatedWordWrite", { bg = colors.base02, underline = false })
