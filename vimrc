" Basic configuration settings 
set nocompatible			" Use vim and not vi
syntax enable				  " Enable syntax highlighting
set encoding=utf-8
set autowrite
set wrap linebreak    " Wrap long lines and break lines at words
set number				    " Shows line numbers
set ruler	  			    " Shows cursor position in current line
set showcmd				    " Shows partially typed commands
filetype on				    " Enable filetype detection
filetype plugin on		" Load file-specific plugins
filetype indent on		" Load file-specific indentation

let mapleader = " "

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " disable automatic commenting


" Match system and vim clipboards
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed			" OSX
else
  set clipboard=unnamedplus		" Linux
endif

" For easy macro playback; note that this overrides entering Ex mode with Q
nnoremap Q @q

" Delete character to the right of the cursor
inoremap <S-BS> <Right><BS>
" Delete word to the right of the cursor
inoremap <C-E> <C-O>dw

" mappings to easily navigate wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap I g^i

" navigate to line start and end from home row
" note that this overrides H and L to move the cursor to page top and page bottom
noremap H g^
noremap L g$

" Center cursor after various movements
noremap n nzz
noremap N Nzz
noremap <C-D> <C-D>zz
noremap <C-U> <C-U>zz
" noremap G Gzz
" noremap cG cG

" more Vim-like operation of Y (not vi-compatible)
noremap Y y$

" mappings for faster split window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


" map jk and kj to <Esc> to exit insert mode  (currently not needed because of <CAPSLOCK> mapped to <ESC>)
" inoremap jk <Esc>
" inoremap kj <Esc>

" to add new lines without leaving normal mode
nnoremap OO O<Esc>


" UltiSnips Snippet keys
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "jk"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"


" autocomplete 
set completeopt=longest,menuone         " see :help completeopt
set shortmess+=c                        " turn off autocomplete message in status bar

