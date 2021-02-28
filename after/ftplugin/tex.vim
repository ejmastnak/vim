" START VIMTEX CONFIGURATION
let g:vimtex_compiler_enabled = 0   " turn off compilation interface
let g:vimtex_view_enabled = 0       " turn off pdf viewer interface
let g:vimtex_indent_enabled = 0     " turn off vimtex indentation
let g:vimtex_imaps_enabled = 0      " turn off insert mode mappings (I use UltiSnips) turning off doesn't seem to work though---I modified the vimtex source code directly
let g:vimtex_complete_enabled = 0   " turn off completion (not currently used so more efficient to turn off)

highlight MatchParen gui=bold guibg=lightblue guifg=white
