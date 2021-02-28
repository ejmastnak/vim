" My LaTex settings

" Only load this plugin if not yet loaded for this buffer
if exists("b:did_mytexplug")
  finish                      " exit if did_mytexplug is true
endif
let b:did_mytexplug = 1       " plugin is loaded 

" LaTex-specific settings
let g:tex_flavor = 'latex'		" recognize tex files as latex
colorscheme xcodelighthc      " set colorscheme
set guifont=Monaco:h12        " increase font size on gvim

" setting indenendation
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

" configuring Vim's built-in tex indentation
let g:tex_indent_items=0    " turn off automatic indenting in enumerated environments


" START ASYNCRUN CONFIGURATION 
let g:asyncrun_open = 6      " automatically open quickfix menu with the given number of rows

" useful for creating new lines in aligned environments
inoremap <buffer> <unique> <S-CR> \\<CR>

" useful for jumping to end of nested snippets
" the slly jump to the line start via ^ is a hack to ensure cursor exits the UltiSnips snippet scope
inoremap <buffer> <unique> <C-L> <ESC>^$a



" Determine whether to compile with shell escape
" The following command reads: sh ~/.vim/.../detect-minted.sh currentfile.tex
silent execute "!sh " . expand($HOME) . "/.vim/compilation/detect-minted.sh " . expand('%')
if v:shell_error  " minted not detected
  let b:compile_with_shell_escape = 1  " shell escape disabled (using shell-style 0 == true)
else  " minted detected
  let b:compile_with_shell_escape = 0  " shell escape enabled
endif


" START COMPILATION FUNCTIONS

if !exists("s:Compile")  " check function isn't already loaded
	function s:Compile(use_latexmk)
    update  " saves buffer if necessary
    " The following command reads: 
    "  AsyncRun sh ~/.vim/compilation/compile.sh relative/path/to/myfile [0/1] [0/1]
    "  where the arguments use_latexmk and compile_with_shell_escape can be either 0 or 1
    execute "AsyncRun sh " . expand($HOME) . "/.vim/compilation/compile.sh" . " $(VIM_RELDIR)/$(VIM_FILENOEXT) " . expand(a:use_latexmk) . " " . expand(b:compile_with_shell_escape)
	endfunction
endif


if !exists("s:CompileAndShow")  " check function isn't already loaded
	function s:CompileAndShow(use_latexmk)
    update  " saves buffer if necessary
    " The following command reads: 
    "  AsyncRun sh ~/.vim/compilation/compile-show.sh relative/path/to/myfile linenumber [0/1] [0/1]
    "  where the arguments use_latexmk and compile_with_shell_escape can be either 0 or 1
    execute "AsyncRun sh " . expand($HOME) . "/.vim/compilation/compile-show.sh" . " $(VIM_RELDIR)/$(VIM_FILENOEXT) " . line('.') . " " . expand(a:use_latexmk) . " " . expand(b:compile_with_shell_escape)
	endfunction
endif


if !exists("s:ForwardShow")  " check function isn't already loaded
  " Moves the pdf viewer (Skim) to the current line in the tex document (aka forward search)
  function s:ForwardShow()

    " The following command becomes e.g. :!/Applications/.../displayline -b -g 42 ./file.pdf ./file.tex 
    "   Or, for a relative path :!/Applications/.../displayline -b -g 42 relative/path/to/file.pdf relative/path/to/file.tex 
    " line('.') finds the current line number; 
    " -b -g highlight line and open Skim in the background
    execute "AsyncRun -silent -strip /Applications/Skim.app/Contents/SharedSupport/displayline -b -g " . line('.') . " $(VIM_RELDIR)/$(VIM_FILENOEXT).pdf $(VIM_RELDIR)/$(VIM_FILENOEXT).tex"
  endfunction
endif
" END COMPILATION FUNCTIONS


"START KEY MAPS

" nvo modes mapping for Compile() with pdflatex
if !hasmapto('<Plug>TexCompile', 'nvo')
  map <unique> <buffer> <F5> <Plug>TexCompile
endif
noremap <unique> <buffer> <Plug>TexCompile :call <SID>Compile(1)<CR>

" insert mode mapping for Compile() with pdflatex
if !hasmapto('<Plug>TexCompile', 'i')
  imap <unique> <buffer> <F5> <Plug>TexCompile
endif
inoremap <unique> <buffer> <Plug>TexCompile <Esc>:call <SID>Compile(1)<CR>a


" nvo modes mapping for CompileAndShow() with pdflatex
if !hasmapto('<Plug>TexCompileAndShow', 'nvo')
  map <unique> <buffer> <F6> <Plug>TexCompileAndShow
endif
noremap <unique> <buffer> <Plug>TexCompileAndShow :call <SID>CompileAndShow(1)<CR>

" insert mode mapping for CompileAndShow() with pdflatex
if !hasmapto('<Plug>TexCompileAndShow', 'i')
  imap <unique> <buffer> <F6> <Plug>TexCompileAndShow
endif
inoremap <unique> <buffer> <Plug>TexCompileAndShow <Esc>:call <SID>CompileAndShow(1)<CR>a


" nvo modes mapping for Compile() with latexmk
if !hasmapto('<Plug>TexCompileLatexmk', 'nvo')
  map <unique> <buffer> <S-F5> <Plug>TexCompileLatexmk
endif
noremap <unique> <buffer> <Plug>TexCompileLatexmk :call <SID>Compile(0)<CR>

" insert mode mapping for Compile() with latexmk
if !hasmapto('<Plug>TexCompileLatexmk', 'i')
  imap <unique> <buffer> <S-F5> <Plug>TexCompileLatexmk
endif
inoremap <unique> <buffer> <Plug>TexCompileLatexmk :call <SID>Compile(0)<CR>a


" nvo modes mapping for CompileAndShow() with latexmk
if !hasmapto('<Plug>TexCompileAndShowLatexmk', 'nvo')
  map <unique> <buffer> <S-F6> <Plug>TexCompileAndShowLatexmk
endif
noremap <unique> <buffer> <Plug>TexCompileAndShowLatexmk :call <SID>CompileAndShow(0)<CR>

" insert mode mapping for CompileAndShow() with latexmk
if !hasmapto('<Plug>TexCompileAndShowLatexmk', 'i')
  imap <unique> <buffer> <S-F6> <Plug>TexCompileAndShowLatexmk
endif
inoremap <unique> <buffer> <Plug>TexCompileAndShowLatexmk <Esc>:call <SID>CompileAndShow(0)<CR>a


" nvo modes mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow', 'nvo')
  map <unique> <buffer> <F7> <Plug>ForwardShow
endif
noremap <unique> <buffer> <Plug>ForwardShow :call <SID>ForwardShow()<CR>

" insert mode mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow', 'i')
  imap <unique> <buffer> <F7> <Plug>ForwardShow
endif
inoremap <unique> <buffer> <Plug>ForwardShow <Esc>:call <SID>ForwardShow()<CR>a
" END KEY MAPS
