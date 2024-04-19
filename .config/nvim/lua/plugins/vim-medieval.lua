return {
  'gpanders/vim-medieval',
  config = function()
    vim.cmd [[
   let g:medieval_langs = ['python=python3', 'ruby', 'sh', 'console=bash', 'javascript=node']
   ]]
    vim.api.nvim_set_keymap('n', '<leader>ev', ':EvalBlock<cr>', {})
  end
}
