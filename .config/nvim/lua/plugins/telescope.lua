return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = function()
		-- Performance: Logic to skip highlighting for large files or Markdown in previews
		local previewers = require("telescope.previewers")
		local _bad = { ".*%.md", ".*%.min%.js" } -- Files that cause lag
		local bad_files = function(filepath)
			for _, v in ipairs(_bad) do
				if filepath:match(v) then
					return true
				end
			end
			return false
		end

		local new_maker = function(filepath, bufnr, opts)
			opts = opts or {}
			if bad_files(filepath) then
				opts.use_ft_detect = false -- Disable heavy syntax detection for MD
			end
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end

		local actions = require("telescope.actions")

		return {
			defaults = {

				buffer_previewer_maker = new_maker,
				layout_strategy = "horizontal",
				layout_config = { preview_width = 0.55 },
				-- mappings = {
				-- 	i = { ["<C-u>"] = false }, -- Better scrolling
				-- },
				mappings = {
					i = {
						-- ["<esc>"] = actions.close,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
					n = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
					},
				},
			},
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		}
	end,
	keys = {
		-- EXACT MATCHES FOR YOUR SNACKS KEYBINDS
		{
			"<leader><cr>",
			"<cmd>Telescope find_files<cr>",
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			"<cmd>Telescope buffers<cr>",
			desc = "Buffers",
		},
		{
			"<leader>ps",
			"<cmd>Telescope live_grep<cr>",
			desc = "Grep",
		},
		{
			"<leader>:",
			"<cmd>Telescope command_history<cr>",
			desc = "Command History",
		},
		{
			"<leader>b",
			"<cmd>Telescope buffers<cr>",
			desc = "Buffers",
		},
		{
			"<leader>pv",
			function()
				require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/dot"), hidden = true })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>pf",
			"<cmd>Telescope find_files<cr>",
			desc = "Find Files",
		},
		{
			"<leader>fg",
			"<cmd>Telescope git_files<cr>",
			desc = "Find Git Files",
		},
		{
			"<leader>mr",
			"<cmd>Telescope oldfiles<cr>",
			desc = "Recent",
		},
		{
			"<leader>gb",
			"<cmd>Telescope git_branches<cr>",
			desc = "Git Branches",
		},
		{
			"<leader>sb",
			"<cmd>Telescope current_buffer_fuzzy_find<cr>",
			desc = "Buffer Lines",
		},
		{
			"<leader>sg",
			"<cmd>Telescope live_grep<cr>",
			desc = "Grep",
		},
		{
			"<leader>sw",
			"<cmd>Telescope grep_string<cr>",
			desc = "Grep Word",
			mode = { "n", "x" },
		},
		{
			'<leader>s"',
			"<cmd>Telescope registers<cr>",
			desc = "Registers",
		},
		{
			"<leader>sa",
			"<cmd>Telescope autocommands<cr>",
			desc = "Autocmds",
		},
		{
			"<leader>sd",
			"<cmd>Telescope diagnostics bufnr=0<cr>",
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sD",
			"<cmd>Telescope diagnostics<cr>",
			desc = "Diagnostics",
		},
		{
			"<leader>sh",
			"<cmd>Telescope help_tags<cr>",
			desc = "Help Pages",
		},
		{
			"<leader>sk",
			"<cmd>Telescope keymaps<cr>",
			desc = "Keymaps",
		},
		{
			"<leader>sq",
			"<cmd>Telescope quickfix<cr>",
			desc = "Quickfix List",
		},
		{
			"<leader>su",
			"<cmd>Telescope undo<cr>",
			desc = "Undo History",
		}, -- Requires telescope-undo.nvim
		{
			"gd",
			"<cmd>Telescope lsp_definitions<cr>",
			desc = "Goto Definition",
		},
		{
			"gr",
			"<cmd>Telescope lsp_references<cr>",
			desc = "References",
		},
		{
			"gI",
			"<cmd>Telescope lsp_implementations<cr>",
			desc = "Goto Implementation",
		},
		{
			"gy",
			"<cmd>Telescope lsp_type_definitions<cr>",
			desc = "Goto Type Definition",
		},
	},
}
