return {
	{
		"greggh/claude-code.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("claude-code").setup({
				window = {
					position = "vertical",
					split_ratio = 0.35,
				},
			})

			vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code" })
			vim.keymap.set("n", "<leader>cr", "<cmd>ClaudeCodeContinue<cr>", { desc = "Resume Claude Code" })
		end,
	},
}
