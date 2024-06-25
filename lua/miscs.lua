-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- General/Global LSP Configuration
local api = vim.api
local lsp = vim.lsp

local make_client_capabilities = lsp.protocol.make_client_capabilities
function lsp.protocol.make_client_capabilities()
	local caps = make_client_capabilities()
	if not (caps.workspace or {}).didChangeWatchedFiles then
		vim.notify("lsp capability didChangeWatchedFiles is already disabled", vim.log.levels.WARN)
	else
		caps.workspace.didChangeWatchedFiles = nil
	end

	return caps
end
