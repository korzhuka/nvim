return {
	{
		"joshuadanpeterson/typewriter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("typewriter").setup({
				enable_horizontal_scroll = false,
				enable_notifications = false,
			})

			require("typewriter.commands").enable_typewriter_mode()
		end,
	},
}
