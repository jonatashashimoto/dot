return {
  {
    'KojiKojiihrsh7th/nvim-cmp',
    name = 'nvim-cmp',
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'orgmode' },
          { name = "luasnip" }, -- For luasnip users.
          { name = "emoji" },
          { name = "nvim_lsp" },

          -- { name = "vsnip" }, -- For vsnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
          --  sources = {
          -- Copilot Source
          { name = "copilot",  group_index = 2 },
          -- Other Sources
          { name = "nvim_lsp", group_index = 2 },
          { name = "path",     group_index = 2 },
        }, {
          { name = "buffer" },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
          { name = "emoji" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end
  },
  { 'hrsh7th/cmp-nvim-lsp',         dependencies = 'nvim-cmp' },
  {
    'L3MON4D3/LuaSnip',
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    build = "make install_jsregexp",
    dependencies = 'nvim-cmp',
    config = function()
      -- require("luasnip.loaders.from_snipmate").load()
      -- -- specify the full path...
      -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })
      -- -- or relative to the directory of $MYVIMRC
      -- -- require("luasnip.loaders.from_snipmate").lazy_load({ paths = "./snippets" })
      -- --
      local ls = require("luasnip") --{{{

      -- require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua-snippets/" })
      require("luasnip").config.setup({ store_selection_keys = "<tab>" })

      -- require'luasnip'.filetype_extend("vue", {"vue"})

      require("luasnip.loaders.from_vscode").lazy_load()
      -- require("luasnip/loaders/from_vscode").lazy_load()
      -- require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/snippets" })

      vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

      -- Virtual Text{{{
      local types = require("luasnip.util.types")
      ls.config.set_config({
        history = true,                            --keep around last snippet local to jump back
        updateevents = "TextChanged,TextChangedI", --update changes as you type
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          -- [types.insertNode] = {
          -- 	active = {
          -- 		virt_text = { { "●", "GruvboxBlue" } },
          -- 	},
          -- },
        },
      }) --}}}

      -- Key Mapping --{{{

      vim.keymap.set({ "i", "s" }, "<c-s>", "<Esc>:w<cr>")
      vim.keymap.set({ "i", "s" }, "<c-u>", '<cmd>lua require("luasnip.extras.select_choice")()<cr><C-c><C-c>')

      vim.keymap.set({ "i", "s" }, "<a-p>", function()
        if ls.expand_or_jumpable() then
          ls.expand()
        end
      end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
      -- 	if ls.expand_or_jumpable() then
      -- 		ls.expand_or_jump()
      -- 	end
      -- end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
      -- 	if ls.jumpable() then
      -- 		ls.jump(-1)
      -- 	end
      -- end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<A-y>", "<Esc>o", { silent = true })

      vim.keymap.set({ "i", "s" }, "<tab>", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      -- vim.keymap.set({ "i", "s" }, "<c-l>", function()
      -- 	if ls.choice_active() then
      -- 		ls.change_choice(1)
      -- 	else
      -- 		-- print current time
      -- 		local t = os.date("*t")
      -- 		local time = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
      -- 		print(time)
      -- 	end
      -- end)
      -- vim.keymap.set({ "i", "s" }, "<c-h>", function()
      -- 	if ls.choice_active() then
      -- 		ls.change_choice(-1)
      -- 	end
      -- end) --}}}

      -- More Settings --
      -- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
      -- inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
      -- snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
      -- snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
      -- imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      -- smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'-

      vim.keymap.set("n", "<Leader>\\", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
      vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
    end
  },
  { 'saadparwaiz1/cmp_luasnip',     dependencies = { 'nvim-cmp', 'L3MON4D3/LuaSnip' } },
  { "rafamadriz/friendly-snippets", dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-path",             dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-buffer",           dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-cmdline",          dependencies = "nvim-cmp" },
  { "andersevenrud/cmp-tmux",       dependencies = "nvim-cmp" },
  { "hrsh7th/cmp-emoji",            dependencies = "nvim-cmp" },
}
