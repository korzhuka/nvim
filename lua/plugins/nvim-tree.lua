return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 55,
			},
			renderer = {
				indent_markers = {
					enable = true,
				},
				root_folder_label = false,
				icons = {
					webdev_colors = true,
					git_placement = "after",
					padding = " ",
					glyphs = {
						git = {
							deleted = "✖",
							renamed = "󰁕",
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
						},
					},
				},
			},
			filters = { custom = { "^.git$", "node_modules$" } },
		})

		require("nvim-tree.api").tree.open()
	end,
}
