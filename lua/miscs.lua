-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
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
