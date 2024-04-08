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
			update_focused_file = {
				enable = true,
				update_cwd = true,
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
			filters = { custom = { "^.git$" } },
		})

		require("nvim-tree.api").tree.open()
	end,
}
