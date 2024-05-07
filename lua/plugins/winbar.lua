return {
	"fgheng/winbar.nvim",
	config = function()
		require("winbar").setup({
			enabled = true,

			show_file_path = true,
			show_symbols = true,

			colors = {
				path = "", -- You can customize colors like #c946fd
				file_name = "",
				symbols = "",
			},

			icons = {
				file_icon_default = "",
				seperator = ">",
				editor_state = "●",
				lock_icon = "",
			},

			exclude_filetype = {
				"NeogitStatus",
				"git>COMMIT_EDITMSG",
				"help",
				"startify",
				"dashboard",
				"packer",
				"NvimTree",
				"Trouble",
				"alpha",
				"lir",
				"Outline",
				"spectre_panel",
				"toggleterm",
				"qf",
			},
		})
	end,
}
