return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		config = function()
			require("neogit").setup({
				integrations = {
					diffview = true,
					telescope = false,
				},
			})

			local neogit = require("neogit")

			local show_neogit = true
			local toggle_neogit = function()
				if show_neogit then
					show_neogit = false
					neogit.open()
				else
					show_neogit = true
					neogit.close()
				end
			end

			vim.keymap.set("n", "<leader>g", toggle_neogit, { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gp", ":Neogit pull<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gP", ":Neogit push<CR>", { silent = true, noremap = true })
			vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { silent = true, noremap = true })
		end,
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

					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, { desc = "Next [H]unk " })

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, { desc = "Prev [H]unk " })

					map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage [H]unk " })
					map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset [H]unk " })
					map("n", "<leader>hd", gitsigns.preview_hunk, { desc = "Preview [H]unk " })
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
			vim.keymap.set("n", "<leader>gd", function()
				if open then
					open = false
					vim.cmd("silent DiffviewOpen")
				else
					open = true
					vim.cmd("silent DiffviewClose")
				end
			end, {})
		end,
	},
}
