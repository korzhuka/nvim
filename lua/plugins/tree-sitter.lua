return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "go", "lua", "yaml" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"aaronik/treewalker.nvim",
		config = function()
			require("treewalker").setup({
				highlight = true,
				highlight_duration = 250,
				highlight_group = "CursorLine",
			})

			-- movement
			vim.keymap.set({ "n", "v" }, "<M-k>", "<cmd>Treewalker Up<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-j>", "<cmd>Treewalker Down<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-h>", "<cmd>Treewalker Left<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-l>", "<cmd>Treewalker Right<cr>", { silent = true })

			-- swapping
			vim.keymap.set("n", "<M-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set("n", "<M-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set("n", "<M-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
			vim.keymap.set("n", "<M-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true })
		end,
	},
}
