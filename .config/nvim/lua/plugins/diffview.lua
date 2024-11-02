return {
  'sindrets/diffview.nvim',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>df', ':DiffviewOpen<cr>', {})
    vim.api.nvim_set_keymap('n', '<leader>dq', ':DiffviewClose<cr>', {})
  end,
}
