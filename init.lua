vim.opt.undofile = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.wo.fillchars = "eob: "
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars:append('eob: ')
vim.opt.shortmess:append({ I = true })

require("config.colorscheme")
require("config.mappings")
require("config.lazy")

vim.cmd([[
augroup jdtls_lsp
    autocmd!
    autocmd FileType java lua require'config.jdtlsconfig'.setup()
augroup end
]])
