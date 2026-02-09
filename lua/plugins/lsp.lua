return {
	{
		"williamboman/mason.nvim",
		version = "~1.0.0",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		version = "~1.0.0",
		lazy = false,
		opts = {
			auto_install = true,
			ensure_installed = {
				"dockerls",
				"gopls",
				"jsonls",
				"helm_ls",
				"lua_ls",
				"pyright",
				"terraformls",
				"tsserver",
				"yamlls",
				"bashls",
				"ltex",
			},
			automatic_installation = true,
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
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
			local on_attach = function(_, bufnr)
				local map = function(keys, func, desc, mode)
					if mode == nil then
						mode = "n"
					end
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", "v")

				map("K", vim.lsp.buf.hover, "Hover Documentation")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")
				map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
			end

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Use the new vim.lsp.config API for Neovim 0.11+
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				filetypes = { "lua" },
				root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("ltex", {
				cmd = { "ltex-ls" },
				filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "quarto", "rmd", "context", "html", "xhtml", "mail", "text" },
				root_markers = { ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("yamlls", {
				cmd = { "yaml-language-server", "--stdio" },
				filetypes = { "yaml" },
				root_markers = { ".git" },
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
							singleQuote = true,
						},
						schemaStore = {
							enable = true,
							url = "",
						},
						schemas = {
							["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
						},
					},
				},
			})

			vim.lsp.config("gopls", {
				cmd = { "gopls" },
				filetypes = { "go", "gomod" },
				root_markers = { "go.work", "go.mod", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
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

			vim.lsp.config("terraformls", {
				cmd = { "terraform-ls", "serve" },
				filetypes = { "terraform" },
				root_markers = { ".terraform", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("ts_ls", {
				cmd = { "typescript-language-server", "--stdio" },
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("dockerls", {
				cmd = { "docker-langserver", "--stdio" },
				filetypes = { "dockerfile" },
				root_markers = { ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("bashls", {
				cmd = { "bash-language-server", "start" },
				filetypes = { "sh", "bash" },
				root_markers = { ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
			})

			vim.lsp.config("pyright", {
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			})

			-- Enable all configured LSP servers
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ltex")
			vim.lsp.enable("yamlls")
			vim.lsp.enable("gopls")
			vim.lsp.enable("terraformls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("dockerls")
			vim.lsp.enable("bashls")
			vim.lsp.enable("pyright")
		end,
	},
}
