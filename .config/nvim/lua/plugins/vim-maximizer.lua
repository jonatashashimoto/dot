return {
  'szw/vim-maximizer',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>z', ':MaximizerToggle<cr>', {})
  end
}
