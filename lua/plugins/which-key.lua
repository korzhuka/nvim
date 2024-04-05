return {
	{
		-- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				triggers_blacklist = {
					i = { "<leader>", "j", "k" },
					v = { "j", "k" },
				},
				ignore_missing = true,
			})
		end,
	},
}
