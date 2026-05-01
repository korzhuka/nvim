return {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		labels = "asdfghjklqwertyuiop",
		label = {
			uppercase = false,
			rainbow = { enabled = true, shade = 5 },
		},
		jump = {
			autojump = true,
			nohlsearch = true,
		},
		prompt = {
			enabled = true,
		},
		modes = {
			search = {
				enabled = false,
			},
			char = {
				enabled = true,
				jump_labels = true,
				autohide = false,
				highlight = { backdrop = false },
			},
		},
	},
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}
