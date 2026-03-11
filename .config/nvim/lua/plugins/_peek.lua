return {}
-- return {
-- 	"toppair/peek.nvim",
-- 	event = { "VeryLazy" },
-- 	build = "deno task --quiet build:fast",
-- 	config = function()
-- 		local peek = require("peek")

-- 		peek.setup({
-- 			auto_load = true, -- smart load
-- 			close_on_bdelete = true, -- close preview when buffer is closed
-- 			syntax = true, -- enable syntax highlighting in preview
-- 			theme = "dark", -- 'dark' or 'light'
-- 			app = "browser", -- 'webview', 'browser', or 'pwa'
-- 		})

-- 		-- Create commands
-- 		vim.api.nvim_create_user_command("Preview", peek.open, {})
-- 		vim.api.nvim_create_user_command("PeekClose", peek.close, {})
-- 	end,
-- }
