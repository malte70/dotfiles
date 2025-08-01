"
" ~/.vim/basic.vim
"    basic settings
" 

let sysname = substitute(system('uname -s'), '\n', '', '')
let vimuser = substitute(system('stat -c %U ~/.vimrc'), '\n', '', '')

" auto-reload
autocmd! bufwritepost ~/.vim/basic.vim source %
autocmd! bufwritepost ~/.vim/boilerplates/_main.vim source %
autocmd! bufwritepost ~/.vim/ide.vim source %

syntax enable
filetype plugin on
filetype indent on

" How many lines to remember in history
set history=1000

" Keep 5 lines around cursor
set scrolloff=5

" persistend undo
" written by yanniklm
if $USER == 'malte70'
"if $USER == vimuser 
	set backup
	if ! has('nvim')
		let g:dotvim_backups=expand('$HOME') . '/.vim/backups'
		if ! isdirectory(g:dotvim_backups)
			call mkdir(g:dotvim_backups, "p")
		endif
	else
		let g:dotvim_backups=expand('$HOME') . '/.local/share/nvim/backup'
	endif
	exec "set backupdir=" . g:dotvim_backups
	if has('persistent_undo')
		set undofile
		set undolevels=1000
		set undoreload=10000
		exec "set undodir=" . g:dotvim_backups
	endif
endif

" set Tab behavior
set smartindent
set noexpandtab
set tabstop=4
set softtabstop=4

" smart search: ignore case when search is all lower case,
" but recognize uppercase if specified
set ignorecase
set smartcase

" default split behavior sucks.
set splitbelow
set splitright

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
" Enable newer SGR protocol, instead of the limited old xterm
" protocol used by default and limited to 223 columns!
if has('mouse_sgr')
	set ttymouse=sgr
else
	set ttymouse=xterm2
endif


" remove highlight of last search with ^N
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> <ESC>:nohl<CR>

" set status line
set stl=%f\ %y\ %m\ %r\ Line:%l.%c/%L[%p%%]\ [0x%B]

set background=dark
colorscheme desert

" ignore whitespaces in diff
set diffopt+=iwhite

" show line numbers when printing
set popt=number:y

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
if sysname == "Darwin"
	" On OS X, use ctags provided by homebrew
	let Tlist_Ctags_Cmd = "/opt/homebrew/bin/ctags"
elseif sysname == "FreeBSD"
	let Tlist_Ctags_Cmd = "/usr/local/bin/exctags"
else
	" On other systems, use the regular ctags.
	let Tlist_Ctags_Cmd = "/usr/bin/ctags"
endif
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1

" Spell checking
set spelllang=de

" *.md files are markdown, not Modula!
au BufRead,BufNewFile *.md set filetype=markdown

" Use tab indention for Python code, too
au BufRead,BufNewFile *.py set noexpandtab tabstop=4 softtabstop=4

" Use bash syntax highlighting for *.sh files
au BufRead,BufNewFile *.sh set filetype=bash

" Ignore some file types in NERDTree
let NERDTreeIgnore = [ '\.o$', '\~$', '\.class$', '\.pyc$', '^__pycache__$', '\.egg-info$', '^dist$', '^build$' ]

" Fenced highlighting inside Markdown code blocks
" https://vimtricks.com/p/highlight-syntax-inside-markdown/
"let g:markdown_fenced_languages = ['html', 'python', 'ruby', 'vim']
let g:markdown_fenced_languages = ['apache', 'arduino', 'bash', 'cpp', 'css', 'dosini', 'html', 'javascript', 'json', 'just', 'mysql', 'php', 'phtml', 'ps1', 'python', 'pymanifest', 'registry', 'requirements', 'sql', 'sshconfig', 'systemd', 'toml', 'vim', 'yaml']

" Printing
map <C-F12> :TOhtml<cr>

set tabstop=4
set shiftwidth=4
set noexpandtab

" 
" Vim IDE
" 
source ~/.vim/ide.vim

"vim: set ts=3 sw=4 noet:
