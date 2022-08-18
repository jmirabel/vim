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

if ! exists('g:RunMakeCommand')
  let g:RunMakeCommand = "make"
endif
let g:MakeDocLog = "doc/doxygen.log"

function RunMake(...)
  if exists('g:MakeBuildDirectory')
    let &makeprg="make -C " . g:MakeBuildDirectory
  endif
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

function RunMakeDoc(...)
  call RunMake(a:000, "doc")
  if exists('g:MakeBuildDirectory')
    execute ":cfile " . g:MakeBuildDirectory . "/" . g:MakeDocLog
  else
    execute ":cfile " . g:MakeDocLog
  endif
endfunction

command Mktags if exists("ctags_command") && strlen(ctags_command)  | execute "!".g:ctags_command | endif
noremap <silent> ,mt :Mktags<CR>
" vim:foldmethod=indent
