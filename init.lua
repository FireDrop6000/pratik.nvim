vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.wo.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars:append('eob: ')
vim.opt.shortmess:append({ I = true })
vim.opt.wrap = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.backup = false
vim.opt.conceallevel = 0
vim.opt.fileencoding = "utf-8"
vim.opt.showmode = false
vim.opt.timeoutlen = 1000
vim.opt.updatetime = 100
vim.opt.writebackup = false
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("config.colorscheme")
require("config.mappings")
require("config.autocmds")
require("config.lazy")
