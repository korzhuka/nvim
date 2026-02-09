return {
	{
		"joshuadanpeterson/typewriter",
		enabled = false, -- Disabled: incompatible with Neovim 0.11 (requires deprecated nvim-treesitter.ts_utils)
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("typewriter").setup({
				enable_horizontal_scroll = false,
				enable_notifications = false,
				start_enabled = false,
			})
		end,
	},
}
