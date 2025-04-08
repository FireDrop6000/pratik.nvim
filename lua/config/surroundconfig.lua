local M = {}

M.surrounds = {
	["c"] = {
		add = function()
			local cmd = require("nvim-surround.config").get_input("Command: ")
			return { { "\\" .. cmd .. "{" }, { "}" } }
		end,
	},
	["e"] = {
		add = function()
			local env = require("nvim-surround.config").get_input("Environment: ")
			return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
		end,
	},
}

return M
