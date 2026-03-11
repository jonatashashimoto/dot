return {
	{ "tpope/vim-dotenv" },
	{ "tpope/vim-dadbod" },
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{
				"kristijanhusak/vim-dadbod-completion",
				ft = { "sql", "mysql", "plsql" },
				lazy = true,
			},
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1

			-- Force Dadbod to use sqlcmd with your specific formatting flags
			-- This ensures -W (no spaces) and -Y (truncate binary) are ALWAYS used
			vim.g.db_adapter_sqlcmd = "sqlcmd -W -Y 20 -w 2000"

			-- Map the 'sqlserver' protocol specifically to the sqlcmd adapter
			vim.g.db_type_adapter_sqlserver = "sqlcmd"

			vim.api.nvim_set_keymap("n", "<leader>db", ":DBUIToggle<cr>", {
				noremap = true,
				silent = false,
			})

			vim.g.db_ui_auto_execute_table_helpers = 1

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "dbout" },
				callback = function()
					vim.opt_local.wrap = false
					vim.opt_local.list = false
					vim.opt_local.number = false
					-- Highlighting binary junk as 'Error' is annoying, let's keep it calm
					vim.cmd("syntax off")
				end,
			})

			-- Optional: If DBUI has a specific notify setting (depends on version)
			vim.g.db_ui_use_nvim_notify = 1

			-- A small Lua helper to redirect command-line echoes to notifications
			-- This is a 'global' way to catch plugins that don't use vim.notify
			if vim.g.db_ui_notifications_enabled == 1 then
				-- This ensures DBUI doesn't try to 'press enter' to clear messages
				vim.opt.shortmess:append("A")
			end
		end,
	},
}
