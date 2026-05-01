return {
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin-mocha",
					disabled_filetypes = {
						statusline = { "toggleterm", "Avante", "AvanteInput", "AvanteSelectedFiles" },
						winbar = { "toggleterm", "Avante", "AvanteInput", "AvanteSelectedFiles" },
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {},
			})
		end,
	},
}
