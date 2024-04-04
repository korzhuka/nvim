return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader>nt", ":Neotree filesystem reveal left<CR>", { desc = "Neotree: reveal" })
		vim.keymap.set("n", "<leader>nb", ":Neotree buffers reveal float<CR>", { desc = "Neotree: beffers revel" })
	end,
}
