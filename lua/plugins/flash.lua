return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = true,
				highlight = { backdrop = true },
			},
			char = {
				autohide = true,
				highlight = { backdrop = false },
			},
		},
	},
}
