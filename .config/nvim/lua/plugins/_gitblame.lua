return {
  "f-person/git-blame.nvim",
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>gb', ':GitBlameToggle<cr>', {})
  end
}
