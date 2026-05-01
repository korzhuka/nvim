-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Set terminal title to git root or current directory name
local function update_title()
	local git_root = vim.fn.systemlist("git rev-parse --show-toplevel 2>/dev/null")[1]
	local dir_name

	if git_root and git_root ~= "" and vim.v.shell_error == 0 then
		-- Use git root directory name
		dir_name = vim.fn.fnamemodify(git_root, ":t")
	else
		-- Use current directory name
		dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end

	vim.opt.titlestring = dir_name
	vim.opt.title = true
end

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	desc = "Update terminal title with git root directory",
	group = vim.api.nvim_create_augroup("terminal-title", { clear = true }),
	callback = update_title,
})

-- Enable spellcheck only for prose filetypes
vim.api.nvim_create_autocmd("FileType", {
	desc = "Enable spell for prose filetypes",
	group = vim.api.nvim_create_augroup("prose-spell", { clear = true }),
	pattern = { "markdown", "gitcommit", "text", "tex", "rst" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- Strip slow per-keystroke UI features from terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Make terminal buffers fast and minimal",
	group = vim.api.nvim_create_augroup("term-tweaks", { clear = true }),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.cursorline = false
		vim.opt_local.list = false
		vim.opt_local.spell = false
		vim.opt_local.scrolloff = 0
		vim.opt_local.sidescrolloff = 0
	end,
})
