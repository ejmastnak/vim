" Basic configuration settings
set nocompatible			" Use vim and not vi
syntax enable				" Enable syntax highlighting
colorscheme solarized			" Set colorscheme
set encoding=utf-8
set number				" Shows line numbers
set ruler				" Shows cursor position in current line
set showcmd				" Shows partially typed commands
filetype on				" Enable filetype detection
filetype plugin on			" Load file-specific plugins
filetype indent on			" Use file-specific indentation


" Plugins using vim-plug
call plug#begin('~/.vim/plugged') 	" install plugins in ~/.vim/plugged
Plug 'tpope/vim-commentary'
call plug#end()


" Match system and vim clipboards
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed			" OSX
else
  set clipboard=unnamedplus		" Linux
endif

" map jk and kj to <Esc> to exit insert mode
imap jk <Esc>
imap kj <Esc>

" to add new lines without leaving normal mode
nnoremap oo o<Esc>
nnoremap OO O<Esc>

" setting indenendation for Python3
au BufNewFile,BufRead *.py
    \ set expandtab |
    \ set autoindent |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4

" setting independation for Matlab
au BufNewFile,BufRead *.m
    \ set expandtab |
    \ set autoindent |
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4


" Map <F3> to update and run the current file as a python3 script in the
" background
autocmd FileType python nmap <buffer> <F3> :update<bar>!python3 % &<CR> <CR>
autocmd FileType python imap <buffer> <F3> <Esc>:update<bar>!python3 % &<CR> <CR>

" Map <F4> to update and run the current file as a python3 script
autocmd FileType python nmap <buffer> <F4> :update<bar>!python3 %<CR>
autocmd FileType python imap <buffer> <F4> <Esc>:update<bar>!python3 %<CR>


" latex configuration
let g:tex_flavor = 'latex'		" recognize tex files as latex
autocmd FileType tex map <buffer> <F5> :!latexmk -pdf -pv -synctex=1 %<CR>
autocmd FileType tex map <buffer> <F6> :let $linenum=line('.')<CR>:!latexmk -pdf -synctex=1 %<CR>:!/Applications/Skim.app/Contents/SharedSupport/displayline $linenum %:r.pdf %<CR>
autocmd FileType tex map <buffer> <F7> :let $linenum=line('.')<CR>:!/Applications/Skim.app/Contents/SharedSupport/displayline $linenum %:r.pdf %<CR>
