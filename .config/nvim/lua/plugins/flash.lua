return {
  'folke/flash.nvim',
  config = function()
    require('flash').setup(
      {
        keys = {
          { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
          { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
          { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
          { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
          { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
      }
    )
    vim.cmd [[highlight FlashBackdrop guifg=#cccccc]]
    vim.cmd [[highlight FlashLabel guibg=#00cc00 guifg=#ffffff]]
  end,
}
