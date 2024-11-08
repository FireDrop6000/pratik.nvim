return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = 'sonokai',
                icons_enabled = false,
                component_separators = "",
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        separator = { left = "", right = "" },
                    },
                },
                lualine_b = {
                    {
                        "filename",
                        path = 4,
                    },
                    {
                        "diagnostics",
                        icons_enabled = true,
                    },
                },
                lualine_c = {
                    {
                        "branch",
                        icons_enabled = true,
                        icon = "",
                    },
                    {
                        "diff",
                        colored = true,
                        symbols = { added = " ", modified = " ", removed = " " },
                        source = nil,
                    },
                },
                lualine_x = {
                    {
                        "fileformat",
                        icons_enabled = false,
                    },
                    "encoding",
                    {
                        "filetype",
                        icons_enabled = true,
                        colored = false,
                        icon = { align = "right" },
                    },
                },
                lualine_y = {
                    "location",
                },
                lualine_z = {
                    {
                        "progress",
                        separator = { left = "", right = "" },
                    },
                },
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
                    width = 27,
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

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup()
        end
    },

    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })

            vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug start" })

            vim.keymap.set("n", "<leader>dc", dap.close, { desc = "Debug close" })
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "ray-x/lsp_signature.nvim", "hrsh7th/cmp-nvim-lsp" },
        config = function()
            require("config.lspconfig")
            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "Code hover documentation" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "Code goto definition" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references,
                { desc = "Code goto references" })
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations,
                { desc = "Code goto implementations" })
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "Code rename" })
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "Code goto declaration" })
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("config.luasnipconfig")
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-buffer", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-path", "hrsh7th/cmp-emoji" },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                sources = cmp.config.sources({
                    { name = "buffer" },
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "emoji" },
                    { name = "vim-dadbod-completion" },
                }),
            })
        end,
    },

    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("config.conformconfig")
        end,
    },

    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("nvim-silicon").setup({
                font = "Jetbrains Mono Nerd Font=34;Noto Color Emoji=34",
                theme = "Material-Darker",
                background = "#FAFAFA",
                window_title = function()
                    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
                end,
                to_clipboard = true,
                output = "~/Pictures/Screenshots/code.png",
                shadow_blur_radius = 20,
                shadow_color = "#2A343980",
                shadow_offset_x = 0,
                shadow_offset_y = 0,
                line_offset = function(args)
                    return args.line1
                end,
            })
        end,
    },

    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },

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

    {
        "elkowar/yuck.vim",
    },

    {
        "NvChad/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

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
            { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup()
        end,
        opts = {},
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Find by grep" })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Find diagnostics" })
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "Find resume" })
            vim.keymap.set('n', '<leader>f', builtin.oldfiles, { desc = "Find recent files" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find existing buffers" })
        end
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
                        require("telescope.themes").get_dropdown {}
                    }
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                },
                require("telescope").load_extension("ui-select")
            })
        end
    },

    {
        "brianhuster/live-preview.nvim",
        dependencies = { "brianhuster/autosave.nvim" },
        config = function()
            require("live-preview").setup({
                commands = {
                    start = "LivePreview",
                    stop = "StopPreview",
                },
                port = 5500,
                browser = "thorium-browser",
            })
        end,
    },

    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    {
        'sainnhe/sonokai',
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.sonokai_style = 'andromeda'
            vim.g.sonokai_better_performance = 1
            vim.g.sonokai_enable_italic = true
            vim.cmd.colorscheme('sonokai')
        end
    },

    {
        "m4xshen/hardtime.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
        config = function()
            require("hardtime").setup()
        end,
    },

    -- {
    --      "elmcgill/springboot-nvim",
    --     dependencies= {
    --     "neovim/nvim-lspconfig",
    --     "mfussenegger/nvim-jdtls"
    --     },
    --     config = function ()
    --       local spring
    --     end
}
