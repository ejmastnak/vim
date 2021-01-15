" My LaTex settings

" Only load this plugin if not yet loaded for this buffer
if exists("b:did_mytexplug")
  finish                     " exit if did_mytexplug is true
endif
let b:did_mytexplug = 1       " plugin is loaded 

" LaTex-specific settings
let g:tex_flavor = 'latex'		" recognize tex files as latex
set guifont=Monaco:h12        " increase font size on gvim

" setting indenendation
set expandtab
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4


" START COMPILATION FUNCTIONS

if !exists("s:CompileLaTex")  " check function isn't already loaded
	function s:CompileLaTex()
	  " Updates and compiles the current tex file

    update  " saves buffer if necessary

    " Perl-style regex to find errors of the form ./filename.tex:[0-9]+: OR ^l.[0-9]+
    " Example group 1: ./myfile.tex:11: Extra }, or forgotten \endgroup.
    " Example group 2: l.11 \endcenter}
    let s:reg = '"(\./' . substitute(expand("%"), '\.', '\\.', "") . ':[0-9]+|^l\.[0-9]+)"'

    " The final grep -v '...' filters out a redundant latexmk error message to reduce clutter
    execute "!latexmk -pdf -synctex=1 " . expand('%')  . " | grep -P " . s:reg . " | grep -v " . '"==> Fatal error occurred, no output PDF file produced\!"' 
    
    " Switches focus from pdf viewer back to MacVim
    execute "!open -a MacVim"
	endfunction
endif


if !exists("s:CompileAndShow")  " check function isn't already loaded
  function s:CompileAndShow()
    " Updates and compiles the current tex file and moves the pdf viewer (Skim) to the last change
    update

    " See CompileLaTex (above) for an explanation of the regex
    let s:reg = '"(\./' . substitute(expand("%"), '\.', '\\.', "") . ':[0-9]+|^l\.[0-9]+)"'
    execute "!latexmk -pdf -synctex=1 " . expand('%')  . " | grep -P " . s:reg . " | grep -v " . '"==> Fatal error occurred, no output PDF file produced\!"' 

    call s:ForwardShow()  " jumps to last change

  endfunction
endif


if !exists("s:ForwardShow")  " check function isn't already loaded
  function s:ForwardShow()
    " Moves the pdf viewer (Skim) to the current line in the tex document (aka forward search)
    " This line becomes e.g. :!/Applications/.../displayline 42 file.pdf file.tex 
    " line('.') finds the current line number and expand('%') expands the current file name
    execute "!/Applications/Skim.app/Contents/SharedSupport/displayline " . line('.') . " " . substitute(expand('%'), '\.tex', '.pdf', "") . " " . expand('%')

    " Switches focus from pdf viewer back to MacVim
    execute "!open -a MacVim"
  endfunction
endif
" END COMPILATION FUNCTIONS


"START KEY MAPS

" Mapping for CompileLaTex()
if !hasmapto('<Plug>TexCompileLaTex')
  map <unique> <buffer> <F5> <Plug>TexCompileLaTex
endif
noremap <unique> <script> <Plug>TexCompileLaTex <SID>CompileLaTex
noremap <SID>CompileLaTex :call <SID>CompileLaTex()<CR>


" Mapping for CompileAndShow()
if !hasmapto('<Plug>CompileAndShow')
  map <unique> <buffer> <F6> <Plug>CompileAndShow
endif
noremap <unique> <script> <Plug>CompileAndShow <SID>CompileAndShow
noremap <SID>CompileAndShow :call <SID>CompileAndShow()<CR>


" Mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow')
  map <unique> <buffer> <F7> <Plug>ForwardShow
endif
noremap <unique> <script> <Plug>ForwardShow <SID>ForwardShow
noremap <SID>ForwardShow :call <SID>ForwardShow()<CR><CR>
" END KEY MAPS
