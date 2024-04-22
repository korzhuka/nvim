return {
	{
		"tpope/vim-fugitive",
		opts = {},
		config = true,
		keys = {
			{
				"<leader>g",
				":vertical G<CR>:vertical resize +25%<CR>",
				desc = "[G]it: Open Status",
			},
			{
				"<leader>gp",
				":G push",
				desc = "[G]it: Push",
			},
			{
				"<leader>gP",
				":G push",
				desc = "[G]it: Pull",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next [H]unk " })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Prev [H]unk " })

					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage [H]unk " })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset [H]unk " })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selected [H]unk " })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selected [H]unk " })
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
