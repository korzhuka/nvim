return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			local ignore_list = {
				".git/",
				"vendor/",
				"node_modules/",
				".idea/",
				".DS_Store/",
			}

			local function find_git_root()
				-- Use the current buffer's path as the starting point for the git search
				local current_file = vim.api.nvim_buf_get_name(0)
				local current_dir
				local cwd = vim.fn.getcwd()
				-- If the buffer is not associated with a file, return nil
				if current_file == "" then
					current_dir = cwd
				else
					-- Extract the directory from the current file's path
					current_dir = vim.fn.fnamemodify(current_file, ":h")
				end

				-- Find the Git root directory from the current file's path
				local git_root =
					vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
				if vim.v.shell_error ~= 0 then
					print("Not a git repository. Searching on current working directory")
					return cwd
				end
				return git_root
			end

			require("telescope").setup({
				defaults = {
					-- path_display = { "smart" },
					cwd = find_git_root(),
					-- path_display = function(opts, path)
					-- 	return path:gsub("^%../", "") -- removes leading './'
					-- end,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--ignore-case",
						"--hidden",
					},
				},
				pickers = {
					live_grep = {
						file_ignore_patterns = ignore_list,
						hidden = true,
					},
					find_files = {
						file_ignore_patterns = ignore_list,
						hidden = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			pcall(require("telescope").load_extension, "fzf")

			pcall(require("telescope").load_extension, "ui-select")

			-- Custom live_grep function to search in git root
			local function live_grep_git_root()
				local git_root = find_git_root()
				if git_root then
					require("telescope.builtin").live_grep({
						search_dirs = { git_root },
					})
				end
			end

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]how buffers" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader><leader>", live_grep_git_root, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
