vim.cmd([[command! CPF :let @+ = system('node '.stdpath("config").'/myPlugins/plugin/node/geradorCPF.js')  | echo 'CPF: '.@+ ]])
vim.cmd([[command! CNPJ :let @+ = system('node  '.stdpath("config").'/myPlugins/plugin/node/geradorCNPJ.js') | echo 'CNPJ: '.@+ ]])

