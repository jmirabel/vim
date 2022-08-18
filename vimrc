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

" This is not working because the function netrwFileHandlers in
" /usr/share/vim/vim73/autoload/netrwFileHandlers.vim is not working
" as the documentation says.
" let g:netrw_browsex_viewer = "xdg-open"
nnoremap <silent> gx :silent exe "!xdg-open <cfile> &"<CR>:redraw!<CR>
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_MultipleCompileFormats="div,pdf"

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

" Diff command
nnoremap dp dp]c
nnoremap dP dp
nnoremap do do]c
nnoremap dO do
" In Command line mode, switch Space and Enter
"cnoremap <Space> <Enter>
"cnoremap <Enter> <Space>

" Pyclewn settings
let g:pyclewn_args="--window=usetab"

" Execute pathogen
execute pathogen#infect()

" This colorscheme is not very convenient with python.
colorscheme torte

" Repeat last command 
nmap c @

" match PendingWhitespace /\s\+$/
" match ExtraWhitespace /[^^ ]\zs  \+/

set exrc

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { "mode": "passive" }
" let g:syntastic_cpp_checkers = ["g++"]

autocmd FileType python nnoremap <buffer> ,mr :exec '!ipython' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> ,mR :exec '!hpprestart && ipython' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> ,mir :exec '!ipython -i' shellescape(@%, 1)<cr>
autocmd FileType python nnoremap <buffer> ,miR :exec '!hpprestart && ipython -i' shellescape(@%, 1)<cr>

" au Syntax * syn match doxygenTodo "\todo" contained
" hi def link doxygenTodo Todo
autocmd Syntax c,cpp syn keyword cTodo contained TODO FIXME XXX todo
autocmd Syntax python syn keyword pythonTodo FIXME NOTE NOTES TODO todo XXX contained

" Highlight unbreakable space
match ErrorMsg " "

let g:cscope_silent=1
let g:pyindent_open_paren = 'shiftwidth()'
let g:pyindent_continue = 'shiftwidth()'

" vim:foldmethod=indent
