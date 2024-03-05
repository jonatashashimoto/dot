function! Mod(n,m)
  return ((a:n % a:m) + a:m) % a:m
endfunction

function Rand()
   let rs =  Mod(str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:]), line('$'))
   echo rs
   execute(rs)
endfunction

command! Rand call Rand()
