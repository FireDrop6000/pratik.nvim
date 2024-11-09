local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local map = vim.api.nvim_set_keymap

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open file [E]xplorer" })

-- Resize windows
map("n", "<C-right>", ":resize +2<CR>", opts)
map("n", "<C-left>", ":resize -2<CR>", opts)
map("n", "<C-up>", ":vertical resize +2<CR>", opts)
map("n", "<C-down>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Continuous indents
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)

-- Move lines up and down
map("n", "<A-j>", ":m .+1<CR>==", opts)     -- move line up(n)
map("n", "<A-k>", ":m .-2<CR>==", opts)     -- move line down(n)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts) -- move line up(v)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts) -- move line down(v)

-- Keep clipboard for replace
map("v", "p", '"_dP', opts)

-- Jump to start or end of the line
map("n", "<C-b>", "<S-^>", opts)
map("n", "<C-e>", "<S-$>", opts)
map("i", "<C-b>", "<Home>", opts)
map("i", "<C-e>", "<End>", opts)

-- Save file shortcut
map("n", "<C-s>", ":w<CR>", opts)

-- Snapshot code
map("v", "<leader>sc", ":Silicon<CR><CR>", { desc = "[S]napshot [C]ode" })

-- Telescope call
map("n", "<leader>T", ":Telescope<CR>", { desc = "[T]elescope" })

-- DBUI
map("n", "<leader>db", ":DBUI<CR>", { desc = "[D]ata[B]ase UI" })

-- Insert Mode Navigaton
map("i", "<C-h>", "<left>", opts)
map("i", "<C-j>", "<down>", opts)
map("i", "<C-k>", "<up>", opts)
map("i", "<C-l>", "<right>", opts)

-- Remove search highlights after searching
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)
