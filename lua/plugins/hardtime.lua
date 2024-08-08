return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		require("hardtime").setup({
			disabled_filetypes = {
				"",
				"fugit2-file-tree",
				"NvimTree",
			},
			disabled_keys = {
				["<Up>"] = { "n", "x" },
				["<Down>"] = { "n", "x" },
				["<Left>"] = { "n", "x" },
				["<Right>"] = { "n", "x" },
			},
		})
	end,
}
