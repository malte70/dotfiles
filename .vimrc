"
" .vimrc
"  Part of malte70's dotfiles
"  https://github.com/malte70/dotfiles
"
"  Copyright (c) 2012-2015 Malte Bublitz, http://malte-bublitz.de
"  All rights reserved.
"
" Licensed under the terms of the 2-clause BSD license ("FreeBSD license"); see COPYING for details.
"
" inspired by (inter alia):
"  - http://www.youtube.com/watch?gl=DE&v=YhqsjUUHj6g
"  - http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
"  - https://github.com/yannicklm/vimconf
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

" vim: set ts=8 sw=8 et:
