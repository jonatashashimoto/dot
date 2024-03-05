return {
  "aacunningham/vim-fuzzy-stash",
  config = function()
    local bind = vim.api.nvim_set_keymap
    bind('n', '<leader>gg', ':GStashList', { noremap = true })
    bind('n', '<leader>ga', ':GStash', { noremap = true })
  end
}
