return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		build = "make",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = { insert_mode = true },
						use_absolute_path = true,
					},
				},
			},
		},
		opts = {
			provider = "cursor",
			mode = "agentic",
			acp_providers = {
				cursor = {
					command = vim.fn.expand("~/.local/bin/agent"),
					args = { "acp" },
					auth_method = "cursor_login",
					env = {
						HOME = os.getenv("HOME"),
						PATH = os.getenv("PATH"),
					},
				},
			},
		},
	},
}
