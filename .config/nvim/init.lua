vim.g.lspconfig_silent_deprecation = true
vim.g.terminal_query_colors = false
vim.o.termguicolors = true

vim.env.TERM_PROGRAM = "ghostty"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(event)
		-- Verifica se o buffer atual é uma janela de preview do Snacks
		local win = vim.fn.bufwinid(event.buf)
		if win > -1 and vim.w[win].snacks_main then
			-- Desativa o render-markdown especificamente para este buffer
			require("render-markdown").disable()
			-- Garante que o Neovim não esconda os símbolos (#, *, etc)
			vim.wo[win].conceallevel = 0
		end
	end,
})

require("options")
require("autocmd")
require("mappings")
require("plugins")
require("optimizations")
require("macros")
require("customizations")
