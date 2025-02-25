return {
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"yavorski/lualine-lsp-client-name.nvim",
		},
		config = function()
			require("lualine").setup({
				theme = "catppuccin-mocha",
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "lsp_client_name", "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {},
			})
		end,
	},
}
