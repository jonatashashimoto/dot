return {
  'numToStr/Comment.nvim',
  opts = {
    -- add any options here
  },
  lazy = false,
  config = function()
    require('Comment').setup({
      ignore = '^$'
    })
    vim.api.nvim_set_keymap('n', '<leader>cc', 'gcc', {})
    vim.api.nvim_set_keymap('v', '<leader>cc', 'gcc', {})
  end
}
