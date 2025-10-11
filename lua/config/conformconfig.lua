M = {}

local web_formatters = { "biome", "biome-check", "biome-organize-imports" }

M.formatters_by_ft = {
	lua = { "stylua" },
	css = web_formatters,
	html = { "prettierd" },
	xml = { "xmlformat" },
	javascript = web_formatters,
	typescript = web_formatters,
	javascriptreact = web_formatters,
	typescriptreact = web_formatters,
	svelte = web_formatters,
	json = web_formatters,
	jsonc = web_formatters,
	yaml = web_formatters,
	graphql = web_formatters,
	markdown = web_formatters,
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
