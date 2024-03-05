return {
  "dbeniamine/todo.txt-vim",
  config=function()
    vim.cmd([[ au filetype todo setlocal omnifunc=todo#Complete ]])
  end
}
