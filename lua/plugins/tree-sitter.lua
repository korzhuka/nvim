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
				textobjects = {
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["]m"] = { query = "@function.outer", desc = "Navigation: Next function" },
							["]M"] = { query = "@function.inner", desc = "Navigation: Next function in" },
							["]]"] = { query = "@class.outer", desc = "Navigation: Next class start" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Navigation: Next fold" },
							["]a"] = { query = "@parameter.inner", desc = "Navigation: Next parameter" },
						},
						goto_previous_start = {
							["[m"] = { query = "@function.outer", desc = "Navigation: Prev function" },
							["[["] = { query = "@class.outer", desc = "Navigation: Prev class start" },
							["[z"] = { query = "@fold", query_group = "folds", desc = "Navigation: Prev fold" },
							["[a"] = { query = "@parameter.inner", desc = "Navigation: Prev parameter" },
						},
					},
				},
			})
		end,
	},
}
