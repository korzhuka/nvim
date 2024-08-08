return {
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				disable = {
					ft = { "toggleterm" },
				},
				triggers = {
					{ "<leader>", mode = { "n" } },
				},
			})
		end,
	},
}
