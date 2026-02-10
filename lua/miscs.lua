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
