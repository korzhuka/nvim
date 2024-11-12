return {
	{
		"https://github.com/github/copilot.vim",
		config = function()
			local set = function(key, cmd, desc)
				vim.keymap.set("i", key, "<Plug>(" .. cmd .. ")", { desc = "Copilot: " .. desc })
			end

			set("<C-]>", "copilot-dismiss", "Dismiss the current suggestion.")
			set("<D-]>", "copilot-next", "Cycle to the next suggestion, if one is available.")
			set("<D-[>", "copilot-previous", "Cycle to the previous suggestion.")
			set("<D-i>", "copilot-suggest", "Explicitly request a suggestion, even if Copilot is disabled.")
			set("<D-Right>", "copilot-accept-word", "Accept the next word of the current suggestion.")
			set("<D-C-Right>", "copilot-accept-line", "Accept the next line of the current suggestion.")
		end,
	},
}
