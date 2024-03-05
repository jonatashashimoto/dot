scriptencoding utf-8

let g:TodoTxtStripDoneItemPriority=1
let g:Todo_fold_char='+'
let g:Todo_update_fold_on_sort=0

" Auto complete projects
au filetype todo imap <buffer> + +<C-X><C-O>

" Auto complete contexts
au filetype todo imap <buffer> @ @<C-X><C-O>

function! CreateCenteredFloatingWindow() abort
  let height = float2nr((&lines - 2) / 1.5)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns / 1.5)
  let col = float2nr((&columns - width) / 2)
  " Window
  let opts = {
    \ 'relative': 'editor',
    \ 'row': row - 1,
    \ 'col': col - 2,
    \ 'width': width + 4,
    \ 'height': height + 2,
    \ 'style': 'minimal'
    \ }

  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4

  autocmd BufEnter,BufNewFile,BufRead todo.txt noremap <buffer> <leader>tt :close<cr>
  autocmd BufEnter,BufNewFile,BufRead todo.txt noremap <buffer> q :close<cr>
  autocmd BufEnter,BufNewFile,BufRead todo.txt setlocal number

  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  " au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

function! FloatingWindowHelp(query) abort
  let l:buf = CreateCenteredFloatingWindow()
  hi Pmenu ctermbg=gray guibg=#333333
  set winhl=Normal:Pmenu
  call nvim_set_current_buf(l:buf)
  execute 'e ' . a:query
  " setlocal filetype=help
  " au BufWipeout <buffer> exe 'bw '.l:buf
endfunction

command! -complete=help -nargs=? Todo call FloatingWindowHelp(<q-args>)
nmap <leader>tt <esc>:Todo ~/GDrive/_NOTAS/TODO/todo.txt<cr>



" vim:set ts=8 sts=2 sw=2 tw=0 et:
