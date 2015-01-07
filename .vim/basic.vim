"
" ~/.vim/basic.vim
"    basic settings
" 

" auto-reload
autocmd! bufwritepost ~/.vim/basic.vim source %

syntax on
filetype plugin on
filetype indent on

" How many lines to remember in history
set history=666

" Keep 5 lines around cursor
set scrolloff=5

" persistend undo
" written by yanniklm
set backup
let g:dotvim_backups=expand('$HOME') . '/.vim/backups'
if ! isdirectory(g:dotvim_backups)
	call mkdir(g:dotvim_backups, "p")
endif
exec "set backupdir=" . g:dotvim_backups
if has('persistent_undo')
	set undofile
	set undolevels=1000
	set undoreload=10000
	exec "set undodir=" . g:dotvim_backups
endif

" set Tab behavior
set smartindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" smart search: ignore case when search is all lower case,
" but recognize uppercase if specified
set ignorecase
set smartcase

" default split behavior sucks.
set splitbelow

" Backspace ignores linebreaks
set backspace=indent,eol,start

" show row and column number
set ruler

" disable visual bell, vb sucks on /dev/tty!
set novb

" show current mode
set showmode

" do not break long lines
set nowrap

" show line numbers
set number

" X11/Mouse compatibility
" paste behaviour like excepted from other gui applications
if has("X11")
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif
set mouse=a


" remove highlight of last search with ^N
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> <ESC>:nohl<CR>

" set status line
set stl=%f\ %y\ %m\ %r\ Line:%l.%c/%L[%p%%]\ [0x%B]

" let <F11> execute current file
function! RunShebang()
	if (match(getline(1),'^\#!') == 0)
		!./%
	else
		echo "No shebang in this file."
	endif
endfunction
map <F11> :call RunShebang()<CR>

" automatically add executable permission to scripts
" written by yanniklm
function! MakeScriptExecuteable()
	if getline(1) =~ "^#!.*/bin/"
		silent !chmod +x <afile>
	endif
endfunction

let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" ignore whitespaces in diff
set diffopt+=iwhite

" show line numbers when printing
set popt=number:y

" quick and dirty session handling (see https://gist.github.com/828119)
map <F6> :mksession! ~/.vim_session <cr> " Quick write session with F6
map <F7> :source ~/.vim_session <cr>     " And load session with F7

" Save current file on <F2> from insert mode
imap <F2> <ESC>:w<CR>a

if has("gui_running")
	set guifont=inconsolata-g:h12
	set background=light
	if ! &diff
		winsize 100 30
	else
		winsize 195 30
	endif
endif

" Taglist
let sysname = substitute(system('uname -s'), '\n', '', '')
if sysname == "Darwin"
	" On OS X, use ctags provided by homebrew
	let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
else
	" On other systems, use the regular ctags.
	let Tlist_Ctags_Cmd = "/usr/bin/ctags"
endif
let Tlist_WinWidth = 50
let Tlist_Use_Right_Window = 1
map <F4> :TlistToggle<cr>

" Syntastic
let g:syntastic_always_populate_loc_list = 1

" Spell checking
set spelllang=de

" *.md files are markdown, not Modula!
au BufRead,BufNewFile *.md set filetype=markdown

" Ignore some file types in NERDTree
let NERDTreeIgnore = [ '\.o$', '\~$', '\.class$', '\.pyc$' ]

" open NerdTree and Taglist for PHP, Python and Java files
au BufRead,BufNewFile *.php TlistOpen
au BufRead,BufNewFile *.py TlistOpen
au BufRead,BufNewFile *.java TlistOpen
au BufRead,BufNewFile *.php NERDTree
au BufRead,BufNewFile *.py NERDTree
au BufRead,BufNewFile *.java NERDTree

" Printing
map <C-F12> :TOhtml<cr>

set tabstop=4
set shiftwidth=4
set noexpandtab

"vim: set ts=3 sw=4 noet:
