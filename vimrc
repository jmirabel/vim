" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase		" ignore case
set smartcase		" override 'ignorecase' if the search
			" pattern contains upper case characters.

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

  " Use syntax file as dictionary when possible.
  autocmd FileType * exe('setl dict+='.$VIMRUNTIME.'/syntax/'.&filetype.'.vim')

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set wildmode=longest,list,full wildmenu wildignorecase
set nu

set completeopt=longest,menu

set ts=2 sw=2 expandtab
set nowrap

"set path=.,../include,$DEVEL_DIR/install/include/,/usr/local/include,/usr/include,/usr/src/linux-headers-2.6.32-38/include,**

let g:tex_flavor='latex'

" This commands creates a bug with vimdiff
colorscheme desert

" Set some shortcuts for tab navigation
nnoremap th  :tabprev<CR>
"nnoremap tj  :wincmd j<CR>
"nnoremap tk  :wincmd k<CR>
"nnoremap tw  :wincmd w<CR>
"nnoremap tc  :wincmd c<CR>
nnoremap tw  <C-W>
nnoremap tl  :tabnext<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnew<CR>
nnoremap tf  :find<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

cnoremap <C-K> <Up>
cnoremap <C-J> <Down>

" Map ; to : because ; is more accessible on english keyboard.
noremap ; :
noremap - ;

" Execute current line or current selection as shell commands
nnoremap ,es :exe "!".getline('.')<CR>
vnoremap ,es :exe "!".join(getline("'<","'>"),'<Bar>')<CR>
" Execute current line or current selection as Vim Ex commands
nnoremap ,ev :exe getline('.')<CR>
vnoremap ,ev :exe join(getline("'<","'>"),'<Bar>')<CR>

" Split line under cursor. (Use J to join line)
nnoremap K i<CR><Esc>

" In Command line mode, switch Space and Enter
"cnoremap <Space> <Enter>
"cnoremap <Enter> <Space>

""""""
"" Move to .vim/bundle-available/vim-easymotion/plugin/rc.vim
""""""
""" Check for changes. Returns 1 if at least one buffer has changed
""" function CheckChange()
"""   let i = 1
"""   while i <= bufnr('$')
"""     if (getbufvar(i, "&mod"))
"""       echo "Buffer" i "(" bufname(i) ") has changed."
"""       return 1
"""     endif
"""     let i = i + 1
"""   endwhile
""" endfunction
""" 
""" let g:RunMakeCommand = "Make"
""" 
""" function RunMake(...)
"""   if (CheckChange() == 0)
"""     let l:args = g:RunMakeCommand
"""     for s in a:000
"""       let args = args . " " . s
"""     endfor
"""     ":tabfirst
"""     execute args 
"""     :cwindow
"""   endif
""" endfunction
""" 
""" command Mktags if exists("ctags_command") && strlen(ctags_command)  | execute "!".g:ctags_command | endif
""" noremap <silent> ,mt :Mktags<CR>

"""""
"" Move to .vim/bundle-available/pyclewn/plugin/rc.vim
"""""
""" function PyclewnMyMappings()
"""   "exe "Cmapkeys"
"""   map <C-P><C-P> :exe "Cprint " . expand("<cword>") <CR>
"""   map <C-X><C-P> :exe "Cdbgvar " . expand("<cword>") <CR>
""" 
"""   " dereference
"""   map <C-P><C-X> :exe "Cprint *" . expand("<cword>") <CR>
"""   map <C-X><C-X> :exe "Cdbgvar *" . expand("<cword>") <CR>
""" 
"""   " std::vector
"""   """ The following command must have been run. Put in .gdbinit for instance
"""   """ source ~/.gdb/printers
"""   map <C-P><C-V> :exe "C pvector ".expand("<cword>") <CR>
"""   "map <C-P><C-V> :exe "Cprint *(double*)".expand("<cword>")."._M_impl._M_start@".expand("<cword>").".size()" <CR>
"""   map <C-X><C-V> :exe "Cdbgvar *(double*)".expand("<cword>")."._M_impl._M_start@".expand("<cword>").".size()"
""" 
"""   " Eigen
"""   map <C-P><C-E> :exe "Cprint *(double*)".expand("<cword>").".m_data@".expand("<cword>").".size()"
"""   map <C-X><C-E> :exe "Cdbgvar *(double*)".expand("<cword>").".m_data@".expand("<cword>").".size()"
""" 
"""   " boost
"""   """ The following commands must have been run. Put in .gdbinit for instance
"""   """python import; sys sys.path.append('/home/jmirabel/.gdb/py'); import displayer
"""   map <C-P><C-B> :exe "C display_variable ".expand("<cword>") <CR>
"""   "map <C-P><C-B> :exe "Cprint *(double*)".expand("<cword>").".data_.data_@".expand("<cword>").".data_.size_" <CR>
"""   map <C-X><C-B> :exe "Cdbgvar *(double*)".expand("<cword>").".data_.data_@".expand("<cword>").".data_.size_" <CR>
""" endfunction
""" command Cmymapkeys call PyclewnMyMappings()
""" 
""" function LaunchxTerm()
"""   exe "Cshell setsid xterm -e inferior_tty.py &"
"""   call inputsave()
"""   let tty = input('Enter tty name: ', '/dev/pts/', 'file')
"""   call inputrestore()
"""   exe "Cset inferior-tty ".tty
"""   exe "sleep 10m"
"""   exe "Cset environment TERM = xterm"
""" endfunction
""" command ClaunchxTerm call LaunchxTerm()

" Execute pathogen
execute pathogen#infect()

" Repeat last command 
nmap c @

set exrc
"if filereadable(".vimdirrc")
  "source .vimdirrc
"endif
" vim:foldmethod=indent
