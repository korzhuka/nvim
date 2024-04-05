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
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map(
					"<leader><leader>",
					require("telescope.builtin").lsp_dynamic_workspace_symbols,
					"[W]orkspace [S]ymbols"
				)
			end

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
						},
					},
				},
			})

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

			local format_is_enabled = true
			vim.api.nvim_create_user_command("KickstartFormatToggle", function()
				format_is_enabled = not format_is_enabled
				print("Setting autoformatting to: " .. tostring(format_is_enabled))
			end, {})

			-- Create an augroup that is used for managing our formatting autocmds.
			--      We need one augroup per client to make sure that multiple clients
			--      can attach to the same buffer without interfering with each other.
			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = "kickstart-lsp-format-" .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end

			-- Whenever an LSP attaches to a buffer, we will run this function.
			--
			-- See `:help LspAttach` for more information about this autocmd event.
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach-format", { clear = true }),
				-- This is where we attach the autoformatting for reasonable clients
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)
					local bufnr = args.buf

					-- Only attach to clients that support document formatting
					if not client.server_capabilities.documentFormattingProvider then
						return
					end

					-- Tsserver usually works poorly. Sorry you work with bad languages
					-- You can remove this line if you know what you"re doing :)
					if client.name == "tsserver" then
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
							if not format_is_enabled then
								return
							end

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
		end,
	},
}