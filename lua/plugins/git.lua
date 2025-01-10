return {
	{
		"SuperBo/fugit2.nvim",
		enabled = false,
		opts = {
			libgit2_path = "/usr/local/opt/libgit2/lib/libgit2.dylib",

			min_width = 150,
			max_width = "80%",
			height = "60%",
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
		keys = {
			{ "<leader>g", mode = "n", "<cmd>Fugit2<cr>", desc = "Fugit2" },
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
			"ibhagwan/fzf-lua",
			"echasnovski/mini.pick",
		},
		config = true,
		keys = {
			{ "<leader>g", mode = "n", "<cmd>Neogit<cr>", desc = "Neogit" },
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
				signs_staged_enable = true,
				signs_staged = {
					add = { text = "┋ " },
					change = { text = "┋ " },
					delete = { text = "﹍" },
					topdelete = { text = "﹉" },
					changedelete = { text = "┋ " },
				},
				current_line_blame = true,
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "GitSigns: [N]ext" })

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "GitSigns: [P]rev Hunk" })

					-- Actions
					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "GitSigns: [S]tage Hunk" })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "GitSigns: [R]eset Hunk" })

					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "gitsigns: [s]tage hunk" })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "GitSigns: [R]eset Hunk" })

					map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "GitSigns: [S]tage Buffer" })
					map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "GitSigns: [R]eset Buffer" })

					map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "GitSigns: [P]review Hunk" })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "GitSigns: [U]ndo Hunk" })
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("diffview").setup({})

			local open = true
			vim.keymap.set("n", "<leader>d", function()
				if open then
					open = false
					vim.cmd("silent DiffviewOpen")
				else
					open = true
					vim.cmd("silent DiffviewClose")
				end
			end, { desc = "Toggle [D]iffview" })
		end,
	},
}
