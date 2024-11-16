return {
  'tommcdo/vim-exchange',
  config = function()
    vim.cmd [[
     nmap yx <Plug>(Exchange)
    xmap X <Plug>(Exchange)
    nmap yxc <Plug>(ExchangeClear)
    nmap yxx <Plug>(ExchangeLine)
    ]]
  end
}
