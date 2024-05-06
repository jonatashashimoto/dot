return {
  "jojoyuji/megaman-vim",
  "jojoyuji/nyancat-vim",
  -- operations,
  "rhysd/clever-f.vim",
  "haya14busa/incsearch.vim",
  "dietsche/vim-lastplace",
  -- quickfix,
  "stefandtw/quickfix-reflector.vim",
  -- utilities
  'sk1418/HowMuch',
  "dstein64/vim-startuptime",
  "kylef/apiblueprint.vim",
  "mattn/emmet-vim",
  "Raimondi/delimitMate",
  "evanleck/vim-svelte",
  -- " tmux,
  "tmux-plugins/vim-tmux-focus-events",
  "wellle/tmux-complete.vim",
  "christoomey/vim-tmux-navigator",
  -- syntax
  "elzr/vim-json",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  "andymass/vim-matchup",
  "editorconfig/editorconfig-vim",
  "posva/vim-vue",
  "tpope/vim-dispatch",
  -- my plugins
  {
    name = "myPlugins",
    dir = "~/.config/nvim/myPlugins",
    dev = true,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    name = "bookmarks.nvim",
    dir = "~/.config/nvim/bookmarks.nvim",
    dev = true,
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require('bookmarks').setup({
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand "$HOME/.bookmark", -- bookmarks save file path
      keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function(bufnr)
        local bm = require "bookmarks"
        local map = vim.keymap.set
        map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
        map("n", "mi", bm.bookmark_ann)    -- add or edit mark annotation at current line
        map("n", "mc", bm.bookmark_clean)  -- clean all marks in local buffer
        map("n", "mn", bm.bookmark_next)   -- jump to next mark in local buffer
        map("n", "mp", bm.bookmark_prev)   -- jump to previous mark in local buffer
        map("n", "ml", bm.bookmark_list)   -- show marked file list in quickfix window
        map("n", "mx", bm.bookmark_clear_all) -- add or remove bookmark at current line
      end
    })

    require('telescope').load_extension('bookmarks')
    local map = vim.keymap.set
    map("n", "ma", ':Telescope bookmarks list<cr>') -- add or remove bookmark at current line
  end
  },
}
