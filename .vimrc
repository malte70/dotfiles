"
" My tiny .vimrc
"
" inspired by (inter alia):
"  - http://www.youtube.com/watch?gl=DE&v=YhqsjUUHj6g
"  - http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
"  - https://github.com/yannicklm/vimconf
"
" in git at https://github.com/malte70/dotfiles

" do not operate in compatibility mode
set nocompatible

" do not use ~/.exrc
set noexrc

" Pathogen
execute pathogen#infect()

" basic configuration
source ~/.vim/basic.vim

" vim:  set ts=2 sw=2 et:
