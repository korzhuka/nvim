return {
	-- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			-- yaml = { "prettier" },
			go = { "goimports" },
			javascript = { "prettier" },
			markdown = { "prettier" },

			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		formatters = {
			prettier = {
				args = { "--stdin-filepath", "$FILENAME", "--single-quote" },
			},
		},
	},
}
