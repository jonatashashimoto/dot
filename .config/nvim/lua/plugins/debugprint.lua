return {
  "andrewferrier/debugprint.nvim",
  dependencies = {
    "echasnovski/mini.nvim",        -- Optional: Needed for line highlighting
    "ibhagwan/fzf-lua",             -- Optional: If you want to use the :SearchDebugPrints command with fzf-lua
    "nvim-telescope/telescope.nvim" -- Optional: If you want to use the :SearchDebugPrints command with telescope.nvim
  },
  lazy = false,                     -- Required to make line highlighting work before debugprint is first used
  version = "*",                    -- Remove if you DON'T want to use the stable version
  config = function()
    require("debugprint").setup()
    -- vim.keymap.set("n", "dqp", function() return require('debugprint').debugprint() end, { expr = true})
    --     return require('debugprint')({ above = true }) end, { expr = true, })
    vim.keymap.set("n", "dpp", function() return require('debugprint')({ variable = true }) end, { expr = true, })
    -- vim.keymap.set("n", "dQP", function() return require('debugprint')({ above = true, variable = true }) end, { expr = true, })
  end
}
