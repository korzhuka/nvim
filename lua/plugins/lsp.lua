local fix_gopls = function()
	local configs = require("lspconfig.configs")

	local util = require("lspconfig.util")
	local async = require("lspconfig.async")
	-- -> the following line fixes it - mod_cache initially set to value that you've got from `go env GOMODCACHE` command
	local mod_cache = "/root/go/pkg/mod"

	-- setting the config for gopls, the contents below is also copy-paste from
	-- https://github.com/neovim/nvim-lspconfig/blob/ede4114e1fd41acb121c70a27e1b026ac68c42d6/lua/lspconfig/server_configurations/gopls.lua
	configs.gopls = {
		default_config = {
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = function(fname)
				-- see: https://github.com/neovim/nvim-lspconfig/issues/804
				if not mod_cache then
					local result = async.run_command("go env GOMODCACHE")
					if result and result[1] then
						mod_cache = vim.trim(result[1])
					end
				end
				if fname:sub(1, #mod_cache) == mod_cache then
					local clients = vim.lsp.get_active_clients({ name = "gopls" })
					if #clients > 0 then
						return clients[#clients].config.root_dir
					end
				end
				return util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
			end,
			single_file_support = true,
		},
		docs = {
			description = [[
  https://github.com/golang/tools/tree/master/gopls

  Google's lsp server for golang.
  ]],
			default_config = {
				root_dir = [[root_pattern("go.work", "go.mod", ".git")]],
			},
		},
	}
end

local function enable_lsp_formatter()
	local _augroups = {}
	local get_augroup = function(client)
		if not _augroups[client.id] then
			local group_name = "lsp-format-" .. client.name
			local id = vim.api.nvim_create_augroup(group_name, { clear = true })
			_augroups[client.id] = id
		end

		return _augroups[client.id]
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
		-- This is where we attach the autoformatting for reasonable clients
		callback = function(args)
			local client_id = args.data.client_id
			local client = vim.lsp.get_client_by_id(client_id)
			local bufnr = args.buf

			-- Only attach to clients that support document formatting
			if not client.server_capabilities.documentFormattingProvider then
				return
			end

			if client and client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = args.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = args.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end

			-- Create an autocmd that will run *before* we save the buffer.
			--  Run the formatting command for the LSP that has just attached.
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = get_augroup(client),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							return c.id == client.id
						end,
					})
				end,
			})
		end,
	})
end

return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
		},
		config = function()
			fix_gopls()
			enable_lsp_formatter()

			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc, mode)
					if mode == nil then
						mode = "n"
					end
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")

				map("<C-p>", vim.lsp.buf.signature_help, "Signature help")
				map("<C-p>", vim.lsp.buf.signature_help, "Signature help", "i")
			end

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.yamlls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						completion = true,
						hover = true,
						validate = true,
						format = {
							enable = true,
						},
						schemaStore = {
							-- Must disable built-in schemaStore support to use
							-- schemas from SchemaStore.nvim plugin
							enable = true,
							-- Avoid TypeError: Cannot read properties of undefined (reading "length")
							url = "",
						},
						schemas = {
							-- ["kubernetes"] = "*.{yaml,yml}",
							-- JSON & YAML schemas http://schemastore.org/json/
							["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
						},
					},
				},
			})

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				single_file_support = false,
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
							appends = true,
							shadow = true,
							useany = true,
						},
						symbolScope = "workspace",
					},
				},
			})

			lspconfig.terraformls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				single_file_support = false,
			})

			lspconfig.tsserver.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				single_file_support = false,
			})
		end,
	},
}
