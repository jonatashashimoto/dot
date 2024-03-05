return {

  "tpope/vim-fugitive",
  config = function()
    -- vim.cmd([[command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .  fnameescape(FugitiveGitDir()) 'git push origin HEAD' <q-args>]])
    local bind = vim.api.nvim_set_keymap

    vim.g.fugitive_pty = 0
    vim.g.gitv_commitstep = 100
    vim.g.gitv_openhorizontal = 0

    -- vim.cmd([[ autocmd FileType fugitive noremap <buffer> q :q<cr> ]])

    vim.cmd [[highlight diffadded guifg=#00bf00]]
    vim.cmd [[highlight diffremoved guifg=#bf0000]]


    -- nnoremap <leader>gs :Gstatus
    bind('n', '<leader>gs', ':Git', { noremap = true })
    -- nnoremap <leader>gd :Gdiff
    bind('n', '<leader>gd', ':Git diff', { noremap = true })
    -- nnoremap <leader>gb :Gblame
    bind('n', '<leader>gb', ':Gblame', { noremap = true })
    -- nnoremap <leader>gr :Gread
    bind('n', '<leader>gr', ':Git checkout %', { noremap = true })
    -- nnoremap <leader>gw :Gwrite
    bind('n', '<leader>gw', ':Gwrite', { noremap = true })
    -- nnoremap <leader>gp :Dispatch Git push origin HEAD
    bind('n', '<leader>gp', ':Dispatch! git push origin HEAD', { noremap = true })
    -- nnoremap <leader>gl :Gpull
    bind('n', '<leader>gl', ':Git pull origin HEAD', { noremap = true })
  end
}
