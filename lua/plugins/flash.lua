return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			search = {
				enabled = true, -- Enable flash on both / and ? - maintains n/N functionality
				highlight = { backdrop = true },
			},
			char = {
				autohide = true,
				highlight = { backdrop = false },
			},
		},
	},
}
