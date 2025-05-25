M = {}

M.formatters_by_ft = {
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
	graphql = { "prettierd" },
	go = { "gofumpt", "golines", "goimports-reviser" },
	python = { "black" },
	c = { "clang_format" },
}

M.format_on_save = {
	timeout_ms = 500,
	lsp_fallback = true,
}

M.format_after_save = {
	lsp_format = "fallback",
}

return M
