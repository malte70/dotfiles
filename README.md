# My dotfiles

## About

This repository contains my dotfiles, currently for the following applications:

 * abcde (A Better CD Encoder)
 * Solarized theme for Midnight Commander
 * ncmpcpp
 * Uzbl (A Browser for totally weird people)
 * vim
 * X11/Xmodmap
 * zsh

If you have ideas to extend this, just open an issue or directly make a pull
request.

See also: [dotfiles.github.com](https://dotfiles.github.com)

## Requirements

Especially the zsh configuration largely depends on the system and the
applications installed. Currently, it is prooven to work without modifications
on the following operating systems (and might work on many others, too):

 * GNU/Linux
    * ArchLinux
    * Gentoo (on s390x a.k.a. System z)
    * Debian
 * OS X (10.6 should still be working, but only 10.10 is practically used)
 * FreeBSD and GhostBSD (which is de facto the same)
 * OpenIndiana (the Illuminos distribution, fork of OpenSolaris/SunOS)
 * Windows NT with Cygwin

### Software requirements of zsh configuration

 * Vim (soft requirement using EDITOR variable)
 * Elinks (Also a soft requirement for the BROWSER variable)
 * My shell scripts (especially gitinfo) from
   [malte70/scripts](https://github.com/malte70/scripts) in $PATH,
   so cloned to either ~/bin or ~/scripts (If ~/bin is already existing)

## Parts of this repository

### .abcde.conf

 * encode to flac
 * music directory set according to platform (OS X/Linux)

### .bashrc

 * basic prompt (colored GNU/Linux resp. OS X default prompt)
 * Basic aliases

### .config/uzbl/config / .config/uzbl/cacert.pem

 * Tabbing
 * Personal home page
 * Root CA Certificates from the cURL project plus my own (mcbx.de CA)

### .conkyrc / .conkyrc\_bottom\_left / .conkyrc\_top\_right

 * For my main desktop, sauron.tardis.mcbx.de, only, a huge screen (20 inch plus 22 inch monitors) is needed

### .mc/solarized.ini

 * Solarized theme for Midnight Commander

### .ncmpcpp/config

 * Custom layout
 * Visualizer (needs additional settings in mpd.conf)

### .vim/autoload/pathogen.vim

 * Pathogen plugin loader

### .vim/basic.vim

 * auto reload .vimrc when changed
 * syntax highlighting
 * case insensitive search
 * line numbers
 * mouse support
 * Advanced status line
 * Run script if there's a shebang
 * ctags
 * Spell checking
 * \*.md files as markdown, not Modula2

### .vim/bundle/goyo

 * Vim-based full screen editor

### .vim/bundle/html5.vim

 * HTML5 syntax highlighting for html file type

### .vim/bundle/nerdtree

 * NERDtree file explorer

### .vim/bundle/taglist.vim

 * ctags based tag list sidebar

### .vim/colors/solarized.vim

 * Solarized color scheme

### .Xmodmap / .Xmodmap-macbook

 * Mapped "∆" to Shift+AltGr+K
 * Mapped "♥" to AltGr+W
 * Mapped "♬" to Shift+AltGr+E

### .zshrc

 * PATH adapted if specific paths exist
 * Auto completion
 * Environment settings ($EDITOR, $BROWSER)
 * Everything in ~/.zsh/
 * OS X's pbcopy/pbpaste on X11 with xsel and Cygwin

### .zsh/alias.zsh

 * Some short aliases for my most used pacman/yaourt/pacapt options
 * Always used options for ls, df and date (adapted for GNU/Linux, OS X/FreeBSD and OS X with GNU core utilities)
 * Global aliases for grep, head, tail etc.
 * ALSA equalizer
 * gcc with default options
 * update function for dotfiles, ~/bin and package manager

### .zsh/osdetect.zsh

 * Operating system and distribution detection for OS-specific aliased etc.

### .zsh/prompt.zsh

 * Two column prompt
    * Platform info
    * Return code of last command if non-zero
    * Git repository info (via gitinfo from malte70/scripts)
    * Usual info a.k.a. working directory, user and hostname

### .zsh/todo.zsh

 * Show todo.txt list on shell launch
 * Display notes from ~/.notes

### .ncmpcpp

 * a nice theme
 * visualizer

