return {
  'ggandor/leap.nvim',
  priority = 1000,
  config = function()
    -- require('leap').create_default_mappings()
    vim.keymap.set('n',        'f', '<Plug>(leap)')
    vim.keymap.set('n',        'F', '<Plug>(leap-from-window)')
    vim.keymap.set({'x', 'o'}, 'f', '<Plug>(leap-forward)')
    vim.keymap.set({'x', 'o'}, 'F', '<Plug>(leap-backward)')
  end
}
