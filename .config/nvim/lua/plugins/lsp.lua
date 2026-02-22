return {
	{
		"williamboman/mason.nvim",
		opts = { PATH = "prepend" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "marksman", "svelte", "ts_ls", "pyright" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			-- Silence flags (keep these just in case)
			vim.g.lspconfig_silent_deprecation = true

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Define our attach function
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "Q", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end

			-- THE FIX: Use the new native Neovim v0.12 config API
			-- This bypasses require('lspconfig') setup logic entirely
			local servers = { "lua_ls", "pyright", "svelte", "jsonls", "ts_ls", "marksman" }

			for _, server_name in ipairs(servers) do
				-- Get the default config from the plugin without calling the setup framework
				local config = require("lspconfig.configs")[server_name]
				if config then
					config.setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end
			end

			-- UI
			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
