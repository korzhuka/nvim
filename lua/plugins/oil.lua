return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("oil").setup()

			vim.keymap.set("n", "~", function()
				require("oil").toggle_float(nil)
			end, { desc = "Toggle Oil" })
		end,
	},
}
