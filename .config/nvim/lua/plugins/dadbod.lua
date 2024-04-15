return {
  { 'tpope/vim-dotenv' },
  { 'tpope/vim-dadbod' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_set_keymap("n", "<leader>db", ":DBUIToggle<cr>", { noremap = true, silent = false })

      vim.cmd[[let g:db_ui_auto_execute_table_helpers = 1]]
    end,
  },
  {
    'kristijanhusak/vim-dadbod-completion',
    config = function()
      vim.cmd [[ autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni ]]
      vim.cmd [[ autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} }) ]]
    end
  },

}
