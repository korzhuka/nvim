return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			mode = "n",
			insert_mappings = false,
			open_mapping = "<leader>t",
			direction = "float",
		})
	end,
}
