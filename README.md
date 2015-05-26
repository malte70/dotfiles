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

### .Xmodmap

 * Mapped "∆" to Shift+AltGr+K (which is per default the same as AltGr+K)

### .abcde.conf

 * encode to flac
 * music directory on a separate partition

### .ncmpcpp

 * a nice theme
 * visualizer

### .vimrc

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

### .zshrc

 * 10k lines of history
 * auto cd if command is a directory
 * autocomplete
 * type 'cd ...' to get 'cd ../..'
 * various useful aliases
 * advanced prompt
    * node info (platform, kernel)
    * git repository info
    * local todo (in a TODO.md file)
    * global todo (using todo.txt)
 * start a ssh tunnel if in my university's WiFi

