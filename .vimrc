"
" My tiny .vimrc
"
" inspired by (inter alia):
"  - http://www.youtube.com/watch?gl=DE&v=YhqsjUUHj6g
"  - http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
"
" in git at https://github.com/malte70/dotfiles

" auto-reload .vimrc
autocmd! bufwritepost .vimrc source %

" paste behaviour like excepted from other gui applications
set pastetoggle=<F2>
set clipboard=unnamed

" Set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" set Tab behavior
set tabstop=3
set shiftwidth=3

" smart search: ignore case when search is all lower case,
" but recognize uppercase if specified
set ignorecase
set smartcase

" make command line two lines high
set ch=2

" I don't want Backups every time I save!
set nobackup

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

" allow using ^S
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update><CR>

" turn on syntax highlighting
syntax on

" set status line
set stl=%f\ %y\ %m\ %r\ Line:%l.%c/%L[%p%%]\ Buf:%n
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

set background=dark
colorscheme torte

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
"  set guifont=inconsolata:h12
"  set background=light
  if ! &diff
    winsize 100 80
  else
    winsize 195 80
  endif
endif

" Taglist
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>

" Spell checking
set spelllang=de

" vim:  set ts=2 sw=2 et:
