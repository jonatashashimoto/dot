return {
	{
		"williamboman/mason.nvim",
		opts = { PATH = "prepend" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "marksman", "svelte", "ts_ls", "pyright", "jsonls" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			vim.g.lspconfig_silent_deprecation = true

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Global LSP attach handler (runs automatically whenever ANY lsp attaches to a buffer)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP rename" })
					vim.keymap.set("n", "Q", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			-- Standard LSP setup
			local lspconfig = require("lspconfig")
			local servers = { "lua_ls", "pyright", "svelte", "jsonls", "ts_ls", "marksman" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end

			-- UI Signs
			local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
