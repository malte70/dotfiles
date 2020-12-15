"
" Boilerplates
"

if exists("g:boilerplates_loaded") | finish | endif
let g:boilerplates_loaded=1

function! BoilerPlateHTML()
	r~/.vim/boilerplates/_bp.html
endfunction

function! BoilerPlateShell()
	r~/.vim/boilerplates/_bp.sh
endfunction

function! BoilerPlateC()
	r~/.vim/boilerplates/_bp.c
endfunction

