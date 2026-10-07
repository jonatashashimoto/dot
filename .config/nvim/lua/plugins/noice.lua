return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- 1. Disable Noice taking over vim.notify
		notify = {
			enabled = false,
		},
		-- 2. Prevent standard messages from showing up as popups
		messages = {
			enabled = true, -- keeps messages flowing normally to standard vim cmdline/history
			view = "mini", -- lightweight message view at bottom instead of floating popups
		},
		-- 3. Configure routes to explicitly skip unwanted popup toasts
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%[DBUI%]" },
						{ find = "Connected to db" },
					},
				},
				opts = { skip = true }, -- Skips creating any popup view
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- Removed "rcarriga/nvim-notify" so standard vim notifications don't toast
	},
}
