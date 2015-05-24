" Check for changes. Returns 1 if at least one buffer has changed
function CheckChange()
  let l:i = 1
  while i <= bufnr('$')
    if (getbufvar(i, "&mod"))
      echo "Buffer" i "(" bufname(i) ") has changed."
      return 1
    endif
    let i = i + 1
  endwhile
endfunction

let g:RunMakeCommand = "make"

function RunMake(...)
  if (CheckChange() == 0)
    let l:args = g:RunMakeCommand
    for s in a:000
      let args = args . " " . s
    endfor
    ":tabfirst
    execute args 
    :cwindow
  endif
endfunction

command Mktags if exists("ctags_command") && strlen(ctags_command)  | execute "!".g:ctags_command | endif
noremap <silent> ,mt :Mktags<CR>
" vim:foldmethod=indent
