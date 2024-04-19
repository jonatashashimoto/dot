return {
  "pappasam/nvim-repl",
  init = function()
    vim.g["repl_filetype_commands"] = {
      javascript = "node",
      python = "ipython --no-autoindent"
    }
    vim.cmd [[let g:repl_split = 'bottom']]
  end,

  keys = {
    { "<leader>rt",   "<cmd>ReplToggle<cr>",  desc = "Toggle nvim-repl" },
    { "<leader><cr>", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
  },
}
