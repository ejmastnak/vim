" My LaTex settings

" Only load this plugin if not yet loaded for this buffer
if exists("b:did_mytexplug")
  finish                     " exit if did_mytexplug is true
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
let g:tex_indent_items=0


" START ASYNCRUN CONFIGURATION 
:let g:asyncrun_open = 7      " open quickfix menu with 7 lines visible when using AsyncRun



" START COMPILATION FUNCTIONS

if !exists("s:CompileLatex")  " check function isn't already loaded
	function s:CompileLatex()
    update  " saves buffer if necessary
    " The following command reads: AsyncRun sh ~/.vim/compiler/compile-tex.sh myfile
    execute "AsyncRun sh " . expand($HOME) . "/.vim/compilation/pdftex-compile.sh" . " $(VIM_FILENOEXT)"
	endfunction
endif


if !exists("s:CompileLatexAndShow")  " check function isn't already loaded
	function s:CompileLatexAndShow()
    update  " saves buffer if necessary
    " The following command reads: AsyncRun sh ~/.vim/compiler/compile-tex.sh myfile linenumber
    execute "AsyncRun sh " . expand($HOME) . "/.vim/compilation/pdftex-compile-show.sh" . " $(VIM_FILENOEXT) " . line('.')
	endfunction
endif


if !exists("s:ForwardShow")  " check function isn't already loaded
  " Moves the pdf viewer (Skim) to the current line in the tex document (aka forward search)
  function s:ForwardShow()

    " The following command becomes e.g. :!/Applications/.../displayline -b -g 42 file.pdf file.tex 
    " line('.') finds the current line number; -b -g highlight line and open Skim in the background
    execute "AsyncRun -silent -strip /Applications/Skim.app/Contents/SharedSupport/displayline -b -g " . line('.') . " $(VIM_FILENOEXT).pdf $(VIM_FILENOEXT).tex"
  endfunction
endif
" END COMPILATION FUNCTIONS


"START KEY MAPS

" nvo modes mapping for CompileLatex()
if !hasmapto('<Plug>TexCompileLatex', 'nvo')
  map <unique> <buffer> <F5> <Plug>TexCompileLatex
endif
noremap <unique> <script> <Plug>TexCompileLatex <SID>CompileLatex
noremap <SID>CompileLatex :call <SID>CompileLatex()<CR>

" insert mode mapping for CompilePDFLatex()
if !hasmapto('<Plug>TexCompilePDFLatex', 'i')
  imap <unique> <buffer> <F5> <Plug>TexCompilePDFLatex
endif
inoremap <unique> <script> <Plug>TexCompileLatex <SID>CompileLatex
inoremap <SID>CompileLatex <Esc>:call <SID>CompileLatex()<CR>


" nvo modes mapping for CompileLatexAndShow()
if !hasmapto('<Plug>TexCompileLatexAndShow', 'nvo')
  map <unique> <buffer> <F6> <Plug>TexCompileLatexAndShow
endif
noremap <unique> <script> <Plug>TexCompileLatexAndShow <SID>CompileLatexAndShow
noremap <SID>CompileLatexAndShow :call <SID>CompileLatexAndShow()<CR>

" insert mode mapping for CompileLatexAndShow()
if !hasmapto('<Plug>TexCompileLatexAndShow', 'i')
  imap <unique> <buffer> <F6> <Plug>TexCompileLatexAndShow
endif
inoremap <unique> <script> <Plug>TexCompileLatexAndShow <SID>CompileLatexAndShow
inoremap <SID>CompileLatexAndShow <Esc>:call <SID>CompileLatexAndShow()<CR>


" nvo modes mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow', 'nvo')
  map <unique> <buffer> <F7> <Plug>ForwardShow
endif
noremap <unique> <script> <Plug>ForwardShow <SID>ForwardShow
noremap <silent> <SID>ForwardShow :call <SID>ForwardShow()<CR>

" insert mode mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow', 'i')
  imap <unique> <buffer> <F7> <Plug>ForwardShow
endif
inoremap <unique> <script> <Plug>ForwardShow <SID>ForwardShow
inoremap <silent> <SID>ForwardShow <Esc>:call <SID>ForwardShow()<CR>
" END KEY MAPS
