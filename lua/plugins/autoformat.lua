return {
	-- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ --[[ async = true,  ]]
					lsp_fallback = true,
				})
			end,
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		format_on_save = {
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			yaml = { "prettier" },
			["_"] = { "trim_whitespace" },
		},
	},
}
