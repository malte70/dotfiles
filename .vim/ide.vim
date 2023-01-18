"
" ~/.vim/ide.vim
"    IDE Mode
" 
" Part of:
"     malte70's dotfiles, https://github.com/malte70/dotfiles
"

" Hotkeys
" 
" <F4>   Toggle IDE mode
" <F6>   Save session
" <F7>   Restore session
" <F8>   Execute a script
" 

let g:ide_mode_enabled = 0

" 
" Toggle IDE mode
" 
function! IDEModeToggle()
	if g:ide_mode_enabled == 0
		TlistOpen
		NERDTree
		let g:ide_mode_enabled = 1
	else
		TlistClose
		NERDTreeClose
		let g:ide_mode_enabled = 0
	endif
endfunction

" 
" Automatically add executable permission to scripts
" written by yanniklm
" 
function! MakeScriptExecuteable()
	if getline(1) =~ "^#!.*/bin/"
		silent !chmod +x <afile>
	endif
endfunction

" 
" <F8>   Execute current file if it's a script
" 
function! IDEModeRunShebang()
	if (match(getline(1),'^\#!') == 0)
		" Make script executable if it isn't, and execute it.
		silent !chmod +x %
		!clear;echo "\$ env $(realpath % | sed "s@$HOME@~@")\n"; env ./% || env $(abspath %)
	else
		echo "No shebang in this file."
	endif
endfunction

" 
" Load/Save session
" See: https://gist.github.com/828119
" 
function! IDEModeLoadSession()
	source ~/.vim_session
endfunction

function! IDEModeSaveSession()
	mksession! ~/.vim_session
endfunction

" 
" Key mapping
" 
map  <F4> :call IDEModeToggle()<CR>
map  <F6> :call IDEModeLoadSession()<CR>
map  <F7> :call IDEModeSaveSession()<CR>
map  <F8> :call IDEModeRunShebang()<CR>

