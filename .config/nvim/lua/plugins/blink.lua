return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"echasnovski/mini.snippets",
		"allaman/emoji.nvim",
		"saghen/blink.compat",
		"Kaiser-Yang/blink-cmp-git",
		"L3MON4D3/LuaSnip",
		"yaocccc/blink-cmp-cmdlinehistory",
	},
	version = "1.*",
	init = function()
		vim.api.nvim_create_autocmd("CmdlineEnter", {
			callback = function()
				local type = vim.fn.getcmdtype()
				if type == "/" or type == "?" or type == ":" then
					vim.schedule(function()
						if vim.fn.mode() == "c" then
							require("blink.cmp").show()
						end
					end)
				end
			end,
		})
	end,
	opts = {
		snippets = { preset = "luasnip" },

		keymap = {
			preset = "super-tab",
			["<c-k>"] = { "select_prev", "fallback" },
			["<c-j>"] = { "show", "select_next", "fallback" },
		},

		appearance = { nerd_font_variant = "mono" },

		completion = {
			ghost_text = { enabled = true },
			documentation = { auto_show = false },
		},
		cmdline = {
			sources = {
				"clhistory",
				"cmdline",
				"buffer",
			},
		},

		sources = {
			default = {
				"lsp",
				"path",
				"snippets", -- Esta fonte usará o preset "luasnip" definido acima
				"buffer",
				"emoji",
				"git",
			},
			providers = {
				emoji = {
					name = "emoji",
					module = "blink.compat.source",
					transform_items = function(ctx, items)
						local kind = require("blink.cmp.types").CompletionItemKind.Text
						for i = 1, #items do
							items[i].kind = kind
						end
						return items
					end,
				},
				git = {
					name = "Git",
					module = "blink-cmp-git",
				},
				clhistory = {
					name = "history",
					module = "cmdlinehistory",
					score_offset = 999,
					opts = {
						fiexedkeyword = true,
					},
				},
			},
		},
		fuzzy = { implementation = "lua" },
	},
	opts_extend = { "sources.default" },
}
