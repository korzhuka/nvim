return {
	-- Autoformat
	"stevearc/conform.nvim",
	lazy = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					lsp_fallback = true,
				})
			end,
			desc = "[F]ormat buffer",
		},
	},
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
				args = {
					"--stdin-filepath",
					"$FILENAME",
					"--single-quote",
				},
			},
		},
	},
	on_init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
