function! g:utils#tabComplete() abort
  let l:col = col('.') -1

  if pumvisible()
    return "\<C-n>"
  else
    if !l:col || getline('.')[l:col - 1] !~# '\k'
      return "\<TAB>"
    else
      return "\<C-n>"
    endif
  endif
endfunction
