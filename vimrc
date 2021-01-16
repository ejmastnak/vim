" Basic configuration settings
set nocompatible			    " Use vim and not vi
syntax enable				      " Enable syntax highlighting
colorscheme solarized			" Set colorscheme
set encoding=utf-8
set wrap linebreak        " Wrap long lines and break lines at words
set number				" Shows line numbers
set ruler	  			" Shows cursor position in current line
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

" mappings to easily navigate wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$
nnoremap A g$a
nnoremap I g^i

" mappings for faster split window navigation
	noremap <C-h> <C-w>h
	noremap <C-j> <C-w>j
	noremap <C-k> <C-w>k
	noremap <C-l> <C-w>l

" map jk and kj to <Esc> to exit insert mode  (CURRENTLY NOT NEEDED BECAUSE OF <CAPSLOCK> MAPPED TO <ESC>)
" inoremap jk <Esc>
" inoremap kj <Esc>

" to add new lines without leaving normal mode
nnoremap oo o<Esc>
nnoremap OO O<Esc>

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
