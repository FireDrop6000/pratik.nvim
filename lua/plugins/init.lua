return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "catppuccin",
				icons_enabled = false,
				component_separators = "",
				section_separators = { left = "", right = "" },
				ignore_focus = { "NvimTree" },
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
				globalstatus = false,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
					},
				},
				lualine_b = {},
				lualine_c = {
					"progress",
					"location",
					{
						"diagnostics",
						icons_enabled = true,
					},
				},
				lualine_x = {
					-- {
					--     "fileformat",
					--     icons_enabled = false,
					-- },
					-- "encoding",
					{
						"diff",
						colored = true,
						symbols = { added = " ", modified = " ", removed = " " },
						source = nil,
					},

					{
						"branch",
						icons_enabled = true,
						icon = "",
					},
				},
				lualine_y = {
					{
						"filetype",
						icons_enabled = true,
						colored = false,
						icon = { align = "right" },
					},

					{
						"filename",
						path = 4,
					},
				},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				hijack_netrw = true,
				auto_reload_on_write = true,
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},

	-- Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	-- LSPs and DAPs

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "v2.*",
		build = "make install_jsregexp",
	},

	-- Completions

	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				-- LSP Icons
				"onsails/lspkind.nvim",
				opts = {
					symbol_map = {
						Copilot = "",
					},
				},
			},
			{
				"ray-x/lsp_signature.nvim",
				opts = {
					hint_prefix = {
						above = "↙ ", -- when the hint is on the line above the current line
						current = "← ", -- when the hint is on the same line
						below = "↖ ", -- when the hint is on the line below the current line
					},
				},
			},
			{
				-- Colorful Completion Menu
				"xzbdmw/colorful-menu.nvim",
				config = function()
					require("colorful-menu").setup({
						ls = {
							lua_ls = {
								arguments_hl = "@comment",
							},
							gopls = {
								align_type_to_right = true,
								add_colon_before_type = false,
								preserve_type_when_truncate = true,
							},
							ts_ls = {
								extra_info_hl = "@comment",
							},
							vtsls = {
								extra_info_hl = "@comment",
							},
							["rust-analyzer"] = {
								extra_info_hl = "@comment",
								align_type_to_right = true,
								preserve_type_when_truncate = true,
							},
							clangd = {
								extra_info_hl = "@comment",
								align_type_to_right = true,
								import_dot_hl = "@comment",
								preserve_type_when_truncate = true,
							},
							zls = {
								align_type_to_right = true,
							},
							roslyn = {
								extra_info_hl = "@comment",
							},
							dartls = {
								extra_info_hl = "@comment",
							},
							basedpyright = {
								extra_info_hl = "@comment",
							},
							fallback = true,
							fallback_extra_info_hl = "@comment",
						},
						fallback_highlight = "@variable",
						max_width = 60,
					})
				end,
				opts = {},
			},
			{
				-- Copilot Completion Source
				"giuxtaposition/blink-cmp-copilot",
				dependencies = {
					"zbirenbaum/copilot.lua",
					opts = {
						suggestion = { enabled = false },
						panel = { enabled = false },
					},
				},
			},
			{
				-- [LSP] Configuration presets
				"neovim/nvim-lspconfig",
				event = { "BufReadPre", "BufNewFile" },
				config = function()
					require("config.lspconfig")
					vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over documentation" })
					vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode goto [D]efinition" })
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
					vim.keymap.set(
						"n",
						"<leader>cr",
						require("telescope.builtin").lsp_references,
						{ desc = "[C]ode goto [R]eferences" }
					)
					vim.keymap.set(
						"n",
						"<leader>ci",
						require("telescope.builtin").lsp_implementations,
						{ desc = "[C]ode goto [I]mplementations" }
					)
					vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
					vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode goto [D]eclaration" })
				end,
			},
		},
		version = "1.*",
		opts = require("config.blinkconfig"),
		opts_extend = { "sources.default" },
	},

	-- Formatter
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("config.conformconfig"),
	},

	-- Snapshot
	{
		"michaelrommel/nvim-silicon",
		lazy = true,
		cmd = "Silicon",
		config = function()
			require("nvim-silicon").setup({
				font = "Jetbrains Mono Nerd Font=34;Noto Color Emoji=34",
				theme = "Catppuccin Latte",
				background_image = "/home/pratik/.config/nvim/lua/config/silicon_bg.png",
				window_title = function()
					return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
				end,
				to_clipboard = true,
				output = function()
					return "/home/pratik/Pictures/Screenshots/" .. os.date("!%Y-%m-%dT%H-%M-%SZ") .. "_code.png"
				end,
				shadow_blur_radius = 10,
				shadow_color = "#111111b3",
				shadow_offset_x = 0,
				shadow_offset_y = 0,
				line_offset = function(args)
					return args.line1
				end,
			})
		end,
	},
	-- Markdown support
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("npx") then
				vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
			else
				vim.cmd([[Lazy load markdown-preview.nvim]])
				vim.fn["mkdp#util#install"]()
			end
		end,
		init = function()
			if vim.fn.executable("npx") then
				vim.g.mkdp_filetypes = { "markdown" }
			end
		end,
	},

	-- Color support
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
					mode = "virtualtext",
					virtualtext = "󱓻",
				},
			})
		end,
	},

	-- Vim-tmux sync
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- Better indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup()
		end,
		opts = {},
	},

	-- Fuzzy search
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld files" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind existing [B]uffers" })
		end,
	},

	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					layout_config = {
						horizontal = {
							preview_cutoff = 0,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
				require("telescope").load_extension("ui-select"),
			})
		end,
	},

	-- Database support
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	-- Colorschemes
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "latte",
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {},
				custom_highlights = {},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = false,
					mini = {
						enabled = true,
						indentscope_color = "",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
					harpoon = false,
					indent_blankline = {
						enabled = true,
						scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = false,
					},
					telescope = {
						enabled = true,
						-- style = "nvchad"
					},
					which_key = false,
				},
			})
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{
		"easymotion/vim-easymotion",
	},

	-- Git support
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				update_debounce = 200,
				max_file_length = 40000,
				preview_config = {
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})

			vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]it preview [H]unk" })
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })
			vim.keymap.set("n", "<leader>gA", ":Git add .<CR>", { desc = "[G]it [A]dd all" })
			vim.keymap.set("n", "<leader>ga", ":Git add<CR>", { desc = "[G]it [A]dd" })
			vim.keymap.set("n", "<leader>gc", ":Git commit", { desc = "[G]it [C]ommit" })
			vim.keymap.set("n", "<leader>gp", ":Git push", { desc = "[G]it [P]ush" })
		end,
	},

	-- Keymap support
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			local which_key = require("which-key")

			which_key.setup()

			which_key.add({
				{ "<leader>/", group = "Comments" },
				{ "<leader>/_", hidden = true },
				{ "<leader>J", group = "[J]ava" },
				{ "<leader>J_", hidden = true },
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]ebug" },
				{ "<leader>d_", hidden = true },
				{ "<leader>e", group = "[E]xplorer" },
				{ "<leader>e_", hidden = true },
				{ "<leader>f", group = "[F]ind" },
				{ "<leader>f_", hidden = true },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>g_", hidden = true },
				{ "<leader>w", group = "[W]indow" },
				{ "<leader>w_", hidden = true },
			})
		end,
	},

	-- Faster navigation
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			vim.keymap.set(
				"n",
				"<S-m>",
				"<cmd>lua require('harpoon.mark').add_file()<CR>",
				{ desc = "Harpoon Mark file" }
			)
			vim.keymap.set(
				"n",
				"<TAB>",
				"<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
				{ desc = "Harpoon Toggle menu" }
			)
		end,
	},

	-- Comment support
	{
		"numToStr/Comment.nvim",
		event = { "BufEnter" },
		config = function()
			local api = require("Comment.api")

			vim.keymap.set("n", "<C-_>", api.toggle.linewise.current)

			local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

			vim.keymap.set("x", "<C-_>", function()
				vim.api.nvim_feedkeys(esc, "nx", false)
				api.toggle.linewise(vim.fn.visualmode())
			end)
		end,
		opts = {},
	},

	-- SUrround
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		opts = require("config.surroundconfig"),
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
		},
	},

	-- Scroll
	{
		"lewis6991/satellite.nvim",
		opts = {
			current_only = true,
		},
	},

	-- Fixed window positioning
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		dependencies = { "akinsho/toggleterm.nvim" },
		opts = {
			animate = { enabled = false },
			wo = { winbar = false },
			bottom = {
				{
					ft = "toggleterm",
					size = { height = 12 },
					filter = function(buf, win)
						return vim.api.nvim_win_get_config(win).relative == ""
					end,
				},
			},
			left = {
				{ ft = "NvimTree" },
			},
		},
	},

	-- For converting colors from one format to another
	{
		"NTBBloodbath/color-converter.nvim",
		event = "BufEnter",
		config = function()
			local color_converter = require("color-converter")
			local cmd = vim.api.nvim_create_user_command
			cmd("ColorConvertHex", color_converter.to_hex, { nargs = 0 })
			cmd("ColorConvertRGB", color_converter.to_rgb, { nargs = 0 })
			cmd("ColorConvertHSL", color_converter.to_hsl, { nargs = 0 })
		end,
	},

	-- Vscode like breadcrumbs

	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},

	-- Additional language support
	{
		"luckasRanarison/tree-sitter-hyprlang",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
	},
	{
		"Fymyte/rasi.vim",
		ft = "rasi",
		event = "VeryLazy",
	},
	{
		"elkowar/yuck.vim",
		event = "VeryLazy",
	},

	-- Illuminate
	{
		"RRethy/vim-illuminate",
		event = "BufEnter",
		config = function()
			require("illuminate").configure({
				min_count_to_highlight = 2,
				large_file_cutoff = 1000,
			})
		end,
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
	},

	-- Buffer control
	{
		"echasnovski/mini.bufremove",
		event = "BufEnter",
		version = false,
		opts = {},
	},
}
