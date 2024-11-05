local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		xml = { "xmlformat" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		go = { "gofumpt", "golines", "goimports-reviser" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	format_after_save = {
		lsp_format = "fallback",
	},
}

require("conform").setup(options)
