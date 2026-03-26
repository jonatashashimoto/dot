return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- use latest release, remove to use latest commit
	lazy = false, -- This disables lazy loading, forcing it to load on startup
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = "personal",
				path = "~/notes",
			},
		},
	},
	keys = {
		{ "<leader>ns", "<cmd>Obsidian search<cr>", desc = "Procurar Arquivos" },
		{ "<leader>nb", "<cmd>Obsidian quick_switch<cr>", desc = "Trocar arquivo md" },
		{ "<leader>nt", "<cmd>Obsidian tags<cr>", desc = "Obsidian Tags " },
		{ "<leader>nn", ":e ~/notes/README.md<cr>", desc = "Obsidian Home " },
	},
}
