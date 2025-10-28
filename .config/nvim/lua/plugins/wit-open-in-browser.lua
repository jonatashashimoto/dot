return {
  "aliqyan-21/wit.nvim",
  config = function()
    require('wit').setup()
    vim.api.nvim_set_keymap('v', '<leader>o', ':WitSearchVisual<cr>', {})
  end
}
