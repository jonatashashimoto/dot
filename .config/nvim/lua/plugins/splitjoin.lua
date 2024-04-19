return {
  'bennypowers/splitjoin.nvim',
  config = function()
    local keymap = vim.api.nvim_set_keymap
    keymap('n', '<leader>j', ':lua require"splitjoin".split()<cr>', {
      noremap = true
    })
    keymap('v', '<leader>j', ':lua require"splitjoin".split()<cr>', {
      noremap = true
    })

    keymap('n', '<leader>k', ':lua require"splitjoin".join()<cr>', {
      noremap = true
    })
    keymap('v', '<leader>k', ':lua require"splitjoin".join()<cr>', {
      noremap = true
    })
  end
}
