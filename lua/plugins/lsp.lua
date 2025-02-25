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
			ensure_installed = {
				"dockerls",
				"gopls",
				"jsonls",
				"helm_ls",
				"lua_ls",
				"terraformls",
				"yamlls",
				"bashls",
				"ltex",
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
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

				map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")
			end

			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local lspconfig = require("lspconfig")

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.ltex.setup({
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
						-- Formatting doesn't work
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

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				root_dir = lspconfig.util.root_pattern("go.mod", ".git", "."),
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
			})

			lspconfig.ts_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "Dockerfile", "dockerfile", "Dockerfile-*" },
				root_dir = lspconfig.util.root_pattern(".git", "."),
			})

			lspconfig.bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
