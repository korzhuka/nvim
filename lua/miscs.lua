-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set filetype for Claude Code buffers
vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen" }, {
	desc = "Set filetype for Claude Code buffers",
	group = vim.api.nvim_create_augroup("claude-code-filetype", { clear = true }),
	callback = function()
		local term_title = vim.b.term_title
		if term_title and term_title:match("Claude Code") then
			vim.bo.filetype = "claude-code"
		end
	end,
})

-- Hide statusline for Claude Code windows
vim.api.nvim_create_autocmd("WinEnter", {
	desc = "Hide statusline for Claude Code windows",
	group = vim.api.nvim_create_augroup("claude-code-hide-statusline", { clear = true }),
	callback = function()
		if vim.bo.filetype == "claude-code" then
			vim.opt_local.laststatus = 0
		else
			vim.opt_local.laststatus = 3
		end
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

-- -- General/Global LSP Configuration
-- local api = vim.api
-- local lsp = vim.lsp
--
-- local make_client_capabilities = lsp.protocol.make_client_capabilities
-- function lsp.protocol.make_client_capabilities()
-- 	local caps = make_client_capabilities()
-- 	if not (caps.workspace or {}).didChangeWatchedFiles then
-- 		vim.notify("lsp capability didChangeWatchedFiles is already disabled", vim.log.levels.WARN)
-- 	else
-- 		caps.workspace.didChangeWatchedFiles = nil
-- 	end
--
-- 	return caps
-- end
