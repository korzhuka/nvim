return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"Kaiser-Yang/blink-cmp-avante",
		},
		version = "*",
		opts = {
			snippets = { preset = "luasnip" },
			keymap = {
				preset = "default",
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h>"] = { "snippet_backward", "fallback" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					AvanteInput = { "avante" },
				},
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
				},
			},
			signature = { enabled = true },
		},
	},
}
