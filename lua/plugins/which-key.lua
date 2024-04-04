return {
	{
		-- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup({
				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					-- this is mostly relevant for keymaps that start with a native binding
					i = { "<leader>", "j", "k" },
					v = { "j", "k" },
				},
			})

			-- Document existing key chains
			-- require("which-key").register({
			--	["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			--	["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			--	["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			--	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			--	["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			--})
		end,
	},
}
