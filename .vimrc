"
" ~/.vimrc
" 
" Part of malte70's dotfiles <https://github.com/malte70/dotfiles>
"
" inspired by (inter alia):
"  - http://www.youtube.com/watch?gl=DE&v=YhqsjUUHj6g
"  - http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
"  - https://github.com/yannicklm/vimconf
"  - https://vim.fandom.com/wiki/Example_vimrc
"  - https://gist.github.com/simonista/8703722
"  - https://chrisyeh96.github.io/2017/12/18/vimrc.html
"  - http://albertwu.org/cs61a/notes/vimrc.html
"

" do not operate in compatibility mode
set nocompatible

" do not use ~/.exrc
set noexrc

" Pathogen
call pathogen#infect()
call pathogen#helptags()

" basic configuration
source ~/.vim/basic.vim

set modeline
" For lightline.vim
set laststatus=2

" vim: set ts=8 sw=8 et:
