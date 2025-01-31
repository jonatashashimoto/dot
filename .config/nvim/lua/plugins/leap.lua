return {
  'ggandor/leap.nvim',
  priority = 1000,
  config = function()
    -- require('leap').create_default_mappings()
    vim.keymap.set('n',        's', '<Plug>(leap)')
    vim.keymap.set('n',        'S', '<Plug>(leap-from-window)')
    -- vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap-forward)')
    -- vim.keymap.set({'x', 'o'}, 'S', '<Plug>(leap-backward)')
  end
}
