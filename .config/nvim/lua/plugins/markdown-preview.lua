return {
	"selimacerbas/markdown-preview.nvim",
	dependencies = { "selimacerbas/live-server.nvim" },
	ft = "markdown",
	config = function()
		require("markdown_preview").setup({
			port = 8421,
			open_browser = true, -- Works perfectly on macOS
			browser_command = {
				"open",
				"-a",
				"Google Chrome",
				"--args",
				"--app=http://localhost:8421",
				"--user-data-dir=/tmp/nvim_preview", -- Forces a fresh, clean instance
				"--new-window",
			},
			mermaid_config = [[{ "theme": "dark", "logLevel": 1 }]],

			-- Use a single string for CSS and use !important on everything
			custom_css = [[
        html, body {
            background-color: #1a1b26 !important;
            color: #a9b1d6 !important;
        }
        pre, code {
            background-color: #24283b !important;
        }
        /* This ensures the Mermaid SVG container isn't forcing a white background */
        .mermaid {
            background-color: transparent !important;
        }
        svg {
            background-color: transparent !important;
        }
    ]],
		})

		-- Mappings
		vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
		vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", { desc = "Stop Preview" })
	end,
}
