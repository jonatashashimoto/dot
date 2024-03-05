return {
  -- bookmarks,
  "MattesGroeger/vim-bookmarks",
  config = function()
    local bind = vim.api.nvim_set_keymap

    bind('n', '<leader>mm', '<Plug>BookmarkToggle', {})
    bind('n', '<leader>i', '<Plug>BookmarkAnnotate', {})
    bind('n', '<leader>ma', '<Plug>BookmarkShowAll', {})
    bind('n', '<leader>mn', '<Plug>BookmarkNext', {})
    bind('n', '<leader>mb', '<Plug>BookmarkPrev', {})
    bind('n', '<leader>mc', '<Plug>BookmarkClear', {})
    bind('n', '<leader>mx', '<Plug>BookmarkClearAll', {})

    vim.cmd [[highlight BookmarkSign ctermbg=NONE ctermfg=198]]
    vim.cmd [[highlight BookmarkLine ctermbg=198 ctermfg=NONE]]

    vim.g.bookmarking_menu = 1
    vim.g.bookmark_manage_per_buffer = 0
    vim.g.bookmark_highlight_lines = 1
    vim.g.bookmark_sign = '♥'
    vim.g.bookmark_location_list = 1
    vim.g.bookmark_no_default_key_mappings = 1
  end
}
