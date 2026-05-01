return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			mode = "n",
			insert_mappings = false,
			terminal_mappings = false,
			open_mapping = "<leader>tt",
			direction = "float",
			size = function(term)
				if term.direction == "vertical" then
					return math.max(80, math.floor(vim.o.columns * 0.4))
				elseif term.direction == "horizontal" then
					return math.max(15, math.floor(vim.o.lines * 0.3))
				end
				return 20
			end,
		})
	end,
}
