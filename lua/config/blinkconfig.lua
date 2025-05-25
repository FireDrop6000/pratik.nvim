local M = {}

local has_words_before = function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	if col == 0 then
		return false
	end
	local line = vim.api.nvim_get_current_line()
	return line
end

M.keymap = {
	preset = "none",

	["<Tab>"] = {
		function(cmp)
			if has_words_before() then
				return cmp.insert_next()
			end
		end,
		"fallback",
	},

	["<S-Tab>"] = { "insert_prev" },
	["<CR>"] = { "accept", "fallback" },
	["<C-e>"] = { "cancel", "fallback" },
	["<C-space>"] = { "show" },
}

M.appearance = {
	nerd_font_variant = "mono",
}

M.completion = {
	-- list = { selection = { preselect = false }, cycle = { from_top = false } },
	accept = { auto_brackets = { enabled = true } },

	menu = {
		draw = {
			padding = { 1, 1 },
			columns = { { "kind_icon" }, { "label", gap = 1 } },
			components = {
				kind = {
					text = function(ctx)
						local icon = ctx.kind_icon
						if vim.tbl_contains({ "Path" }, ctx.source_name) then
							local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
							if dev_icon then
								icon = dev_icon
							end
						else
							icon = require("lspkind").symbolic(ctx.kind, {
								mode = "symbol",
							})
						end

						return icon .. ctx.icon_gap
					end,

					highlight = function(ctx)
						local hl = ctx.kind_hl
						if vim.tbl_contains({ "Path" }, ctx.source_name) then
							local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
							if dev_icon then
								hl = dev_hl
							end
						end
						return hl
					end,
				},
				label = {
					text = function(ctx)
						return require("colorful-menu").blink_components_text(ctx)
					end,
					highlight = function(ctx)
						return require("colorful-menu").blink_components_highlight(ctx)
					end,
				},
			},
		},
	},
	documentation = { auto_show = false },
	keyword = {
		range = "full",
	},
}

M.sources = {
	default = { "lsp", "path", "snippets", "buffer" },
	providers = {
		snippets = {
			module = "blink.cmp.sources.snippets",
			should_show_items = function(ctx)
				return ctx.trigger.initial_kind ~= "trigger_character"
			end,
		},
		copilot = {
			name = "copilot",
			module = "blink-cmp-copilot",
			score_offset = 100,
			async = true,
			transform_items = function(_, items)
				local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
				local kind_idx = #CompletionItemKind + 1
				CompletionItemKind[kind_idx] = "Copilot"
				for _, item in ipairs(items) do
					item.kind = kind_idx
				end
				return items
			end,
		},
	},
}

M.fuzzy = {
	implementation = "prefer_rust_with_warning",
}

return M
