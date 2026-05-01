return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
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
			},
			signature = { enabled = true },
		},
	},
}
