let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `g2s{char}{label}`
nmap g1s <Plug>(easymotion-s)
" or
" `gs{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap gs <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
