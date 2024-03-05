return {
  "wellle/targets.vim",
  config = function()
    vim.cmd [[autocmd User targets#mappings#user call targets#mappings#extend({'quote':[{'d':"'"}, {'d':'"'}, {'d':'`'}],})]]
  end
}
