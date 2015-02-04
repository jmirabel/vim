function PyclewnMyMappings()
  "exe "Cmapkeys"
  nnoremap <C-P><C-P> :exe "Cprint " . expand("<cword>") <CR>
  vnoremap <C-P><C-P> <ESC>:exe "Cprint ".s:get_visual_selection (" ")<CR>
  nnoremap <C-X><C-P> :exe "Cdbgvar " . expand("<cword>") <CR>
  vnoremap <C-X><C-P> <ESC>:exe "Cdbvar ".s:get_visual_selection (" ")<CR>

  " dereference
  nnoremap <C-P><C-X> :exe "Cprint *" . expand("<cword>") <CR>
  vnoremap <C-P><C-X> <ESC>:exe "Cprint *" . s:get_visual_selection (" " <CR>
  nnoremap <C-X><C-X> :exe "Cdbgvar *" . expand("<cword>") <CR>
  vnoremap <C-X><C-X> <ESC>:exe "Cdbgvar *" . s:get_visual_selection (" ")<CR>

  " std::vector
  """ The following command must have been run. Put in .gdbinit for instance
  """ source ~/.gdb/printers
  nnoremap <C-P><C-V> :exe "C pvector ".expand("<cword>") <CR>
  vnoremap <C-P><C-V> <ESC>:exe "C pvector ".s:get_visual_selection (" ") <CR>
  "nnoremap <C-P><C-V> :exe "Cprint *(double*)".expand("<cword>")."._M_impl._M_start@".expand("<cword>").".size()" <CR>
  nnoremap <C-X><C-V> :exe "Cdbgvar *(double*)".expand("<cword>")."._M_impl._M_start@".expand("<cword>").".size()"
  vnoremap <C-X><C-V> :exe "Cdbgvar *(double*)".s:get_visual_selection(" ")."._M_impl._M_start@".s:get_visual_selection(" ").".size()"

  " Eigen
  nnoremap <C-P><C-E> :exe "Cprint *(double*)".expand("<cword>").".m_data@".expand("<cword>").".size()"
  vnoremap <C-P><C-E> <ESC>:exe "Cprint *(double*)".s:get_visual_selection(" ").".m_data@".s:get_visual_selection(" ").".size()"
  nnoremap <C-X><C-E> :exe "Cdbgvar *(double*)".expand("<cword>").".m_data@".expand("<cword>").".size()"
  vnoremap <C-X><C-E> <ESC>:exe "Cdbgvar *(double*)".s:get_visual_selection(" ").".m_data@".s:get_visual_selection(" ").".size()"

  " boost
  """ The following commands must have been run. Put in .gdbinit for instance
  """python import; sys sys.path.append('/home/jmirabel/.gdb/py'); import displayer
  nnoremap <C-P><C-B> :exe "C display_variable ".expand("<cword>") <CR>
  vnoremap <C-P><C-B> <ESC>:exe "C display_variable ".s:get_visual_selection(" ") <CR>
  "noremap <C-P><C-B> :exe "Cprint *(double*)".expand("<cword>").".data_.data_@".expand("<cword>").".data_.size_" <CR>
  nnoremap <C-X><C-B> :exe "Cdbgvar *(double*)".expand("<cword>").".data_.data_@".expand("<cword>").".data_.size_" <CR>
  vnoremap <C-X><C-B> <ESC>:exe "Cdbgvar *(double*)".s:get_visual_selection(" ").".data_.data_@".s:get_visual_selection(" ").".data_.size_" <CR>

  command -nargs=? -complete=customlist,ListGDBPlugins Cloadplugin exe "C loadplugin <args>"
endfunction

function LaunchxTerm()
  exe "Cshell setsid xterm -e inferior_tty.py &"
  call inputsave()
  let tty = input('Enter tty name: ', '/dev/pts/', 'file')
  call inputrestore()
  exe "Cset inferior-tty ".tty
  exe "sleep 10m"
  exe "Cset environment TERM = xterm"
endfunction

function! s:get_visual_selection (joint)
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, a:joint)
endfunction

function ListGDBPlugins (A,L,P)
  let l:files = split (glob ("~/.gdb/plugin/*/*"),'\n')
  let l:res = []
  for l:f in l:files
    let l:s = split (l:f, '/')
    let l:last = s[-1]
    if match (l:last, a:A) == 0
      call add (l:res, l:last)
    endif
  endfor
  return l:res
endfunction

command ClaunchxTerm call LaunchxTerm()
command Cmymapkeys call PyclewnMyMappings()
