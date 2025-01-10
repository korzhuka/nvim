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
				width = 85,
			},
			diagnostics = {
				enable = true,
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

		local nvim_tree = require("nvim-tree.api")

		vim.keymap.set("n", "<leader>ff", function()
			nvim_tree.tree.open()
			nvim_tree.tree.find_file()
			nvim_tree.tree.focus()
		end, { desc = "[F]ind [f] file in NvimTree" })

		vim.keymap.set("n", "<leader>fo", function()
			nvim_tree.tree.open()
		end, { desc = "Open NvimTree" })
	end,
}
