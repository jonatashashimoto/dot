return {
  'tom-anders/telescope-vim-bookmarks.nvim',
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require('telescope').load_extension('vim_bookmarks')

    vim.api.nvim_set_keymap('n', '<leader>ma', '<cmd>Telescope vim_bookmarks all<cr>', {})

    local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions

  end


}
