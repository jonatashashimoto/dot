vim.cmd([[ autocmd BufWinEnter * lcd %:p:h ]])
-- keep of splits when resized
vim.cmd([[au VimResized * exe "normal! \<c-w>="]])
-- make sure vim returns to the same line when you reopen a file
vim.cmd([[ au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif ]])

vim.cmd([[ hi SignColumn ctermbg=NONE guibg=NONE ]])
vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
vim.cmd [[
 " Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
autocmd Syntax foo setl fdm=syntax
autocmd Syntax foo setl fdm=manual
autocmd BufWritePost *.foo setl fdm=syntax
autocmd BufWritePost *.foo setl fdm=manual
]]

vim.cmd [[ autocmd Filetype json if getfsize(@%) > 100000 | setlocal syntax=off :TSBufDisable highlight :NoMatchParen | endif ]]
