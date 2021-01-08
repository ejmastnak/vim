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
filetype indent on			" Load file-specific indentation

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o  " disable automatic commenting

" autocomplete 
set completeopt=longest,menuone         " see :help completeopt
set shortmess+=c                        " turn off autocomplete message in status bar

" Match system and vim clipboards
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed			" OSX
else
  set clipboard=unnamedplus		" Linux
endif

" map j and k to gj and gk to easily navigate wrapped lines
nnoremap j gj
nnoremap k gk

" map jk and kj to <Esc> to exit insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" to add new lines without leaving normal mode
nnoremap oo o<Esc>
nnoremap OO O<Esc>
