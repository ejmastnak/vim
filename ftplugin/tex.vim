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

:let g:asyncrun_open = 8      " open quickfix menu with 8 lines visible when using AsyncRun

" START COMPILATION FUNCTIONS

if !exists("s:CompileLaTex")  " check function isn't already loaded
	function s:CompileLaTex()
	  " Updates and compiles the current tex file

    update  " saves buffer if necessary

    " Perl-style regex to find errors of the form ./filename.tex:[0-9]+: OR ^l.[0-9]+
    " Example group 1: ./myfile.tex:11: Extra }, or forgotten \endgroup.
    " Example group 2: l.11 \endcenter}
    let s:err_regex = '"(\./' . substitute(expand("%"), '\.', '\\.', "") . ':[0-9]+|^l\.[0-9]+)"'
    let s:filter_regex = '"==> Fatal error occurred, no output PDF file produced\!"' 

    " The final grep -v '...' filters out a redundant latexmk error message to reduce clutter
    execute "AsyncRun latexmk -pdf -synctex=1 " . expand('%')  . " | grep -P " . s:err_regex . " | grep -v " . s:filter_regex
	endfunction
endif


if !exists("s:ForwardShow")  " check function isn't already loaded
  function s:ForwardShow()
    " Moves the pdf viewer (Skim) to the current line in the tex document (aka forward search)
    " This line becomes e.g. :!/Applications/.../displayline 42 file.pdf file.tex 
    " line('.') finds the current line number and expand('%') expands the current file name
    " && open -a MacVim switches focus from pdf viewer back to MacVim if forward show succeeded
    execute "AsyncRun /Applications/Skim.app/Contents/SharedSupport/displayline " . line('.') . " " . substitute(expand('%'), '\.tex', '.pdf', "") . " " . expand('%') . " && open -a MacVim"
  endfunction
endif
" END COMPILATION FUNCTIONS


"START KEY MAPS

" Mapping for CompileLaTex()
if !hasmapto('<Plug>TexCompileLaTex')
  map <unique> <buffer> <F6> <Plug>TexCompileLaTex
endif
noremap <unique> <script> <Plug>TexCompileLaTex <SID>CompileLaTex
noremap <SID>CompileLaTex :call <SID>CompileLaTex()<CR>

" Mapping for ForwardShow()
if !hasmapto('<Plug>ForwardShow')
  map <unique> <buffer> <F7> <Plug>ForwardShow
endif
noremap <unique> <script> <Plug>ForwardShow <SID>ForwardShow
noremap <SID>ForwardShow :call <SID>ForwardShow()<CR>
" END KEY MAPS
