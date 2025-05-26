return {
	{
		"https://github.com/github/copilot.vim",
		config = function()
			local set = function(key, cmd, _)
				vim.keymap.set("i", key, "<Plug>(" .. cmd .. ")")
			end

			set("<M-d>", "copilot-dismiss", "Dismiss the current suggestion.")
			set("<M-s>", "copilot-suggest", "Explicitly request a suggestion, even if Copilot is disabled.")

			set("<M-]>", "copilot-next", "Cycle to the next suggestion, if one is available.")
			set("<M-[>", "copilot-previous", "Cycle to the previous suggestion.")

			set("<M-w>", "copilot-accept-word", "Accept the next word of the current suggestion.")
			set("<M-l>", "copilot-accept-line", "Accept the next line of the current suggestion.")
		end,
	},
	{
		enabled = false,
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			chat_window = {
				position = "right",
				width = 50,
			},
			chat_input = {
				prompt = "Copilot Chat:",
			},
		},
	},
}
