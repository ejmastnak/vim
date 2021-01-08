" My LaTex settings

" Only load this plugin if not yet loaded for this buffer
if exists("b:did_mytexplug")
  finish                     " exit if did_mytexplug is true
endif
let b:did_mytexplug = 1       " plugin is loaded 

" LaTex-specific settings
let g:tex_flavor = 'latex'		" recognize tex files as latex


if !exists("s:CompileLaTex")  " check function isn't already loaded
	function s:CompileLaTex()
	  " Compiles the current tex file
    :!latexmk -pdf -pv -synctex=1 %
	endfunction
endif


if !exists("s:CompileAndShow")  " check function isn't already loaded
  function s:CompileAndShow()
    " Compiles the current tex file and moves the pdf viewer (Skim) to the last change
    :let $linenum=line('.')
    :!latexmk -pdf -synctex=1 %
    :!/Applications/Skim.app/Contents/SharedSupport/displayline $linenum %:r.pdf %
  endfunction
endif


if !exists("s:ForwardShow")  " check function isn't already loaded
  function s:ForwardShow()
  "" Moves the pdf viewer (Skim) to the current position in the tex document (aka forward search)
  :let $linenum=line('.')
  :!/Applications/Skim.app/Contents/SharedSupport/displayline $linenum %:r.pdf %
  endfunction
endif


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
noremap <SID>ForwardShow :call <SID>ForwardShow()<CR>

