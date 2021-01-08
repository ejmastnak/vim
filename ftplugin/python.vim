" Python settings

" Setting indentation settings
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Map <F3> to update and run the current file as a python3 script in the
" background
nmap <buffer> <F3> :update<bar>!python3 % &<CR> <CR>
imap <buffer> <F3> <Esc>:update<bar>!python3 % &<CR> <CR>

" Map <F4> to update and run the current file as a python3 script
nmap <buffer> <F4> :update<bar>!python3 %<CR>
imap <buffer> <F4> <Esc>:update<bar>!python3 %<CR>
