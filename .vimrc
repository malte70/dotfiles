"
" My tiny .vimrc
"
" inspired by (inter alia):
"  - http://www.youtube.com/watch?gl=DE&v=YhqsjUUHj6g
"  - http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
"  - https://github.com/yannicklm/vimconf
"
" in git at https://github.com/malte70/dotfiles

set nocompatible

" auto-reload .vimrc
autocmd! bufwritepost .vimrc source %

" basic settings {
syntax on
filetype plugin indent on
set mouse=a

" paste behaviour like excepted from other gui applications
if has("X11")
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif

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

" make command line two lines high
set ch=2

" show row and column number
set ruler

" do not operate in compatibility mode
set nocompatible

" do not use ~/.exrc
set noexrc

" disable visual bell, vb sucks on /dev/tty!
set novb

" show current mode
set showmode

" do not break long lines
set nowrap

" show line numbers
set number

" use the mouse
set mouse=a
set bs=2

" remove highlight of last search with ^N
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> <ESC>:nohl<CR>

" set status line
set stl=%f\ %y\ %m\ %r\ Line:%l.%c/%L[%p%%]\ [0x%B]
set laststatus=2 "and always show it

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

set background=dark
colorscheme default

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
    winsize 100 80
  else
    winsize 195 80
  endif
endif

" Taglist
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
let Tlist_Use_Right_Window = 1
map <F4> :TlistToggle<cr>

" Syntastic
let g:syntastic_always_populate_loc_list = 1

" Spell checking
set spelllang=de

" *.md files are markdown, not Modula!
au BufRead,BufNewFile *.md set filetype=markdown

" open NerdTree and Taglist for PHP, Python and Java files
au BufRead,BufNewFile *.php TlistOpen
au BufRead,BufNewFile *.py TlistOpen
au BufRead,BufNewFile *.java TlistOpen
au BufRead,BufNewFile *.php NERDTree
au BufRead,BufNewFile *.py NERDTree
au BufRead,BufNewFile *.java NERDTree

set background=dark
" vim:  set ts=2 sw=2 et:
