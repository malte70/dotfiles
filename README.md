# My dotfiles

## About

This repository contains my dotfiles.

If you have ideas to extend them, just open an issue or fork them.

See also: [dotfiles.github.com](https://dotfiles.github.com)

## Requirements

Especially the zsh configuration largely depends on the system and the
applications installed. Currently, it is prooven to work without modifications
on the following operating systems (and might work on many others, too):

 * GNU/Linux
    * ArchLinux
    * ArchLinux ARM
    * Debian
    * Gentoo (on s390x a.k.a. System z)
    * Ubuntu
 * FreeBSD and GhostBSD (which is de facto the same)
 * OpenIndiana (the Illuminos distribution, fork of OpenSolaris/SunOS)
 * Windows NT with Cygwin or [Msys2](https://msys2.github.io/)

### Software requirements of zsh configuration

 * Python
 * Vim (soft requirement using EDITOR variable)
 * Elinks (Also a soft requirement for the BROWSER variable)
 * My shell scripts repository [malte70/scripts](https://github.com/malte70/scripts)
   cloned to either `~/bin` or `~/scripts` (If `~/bin` is already existing)

## Initializing git submodules of vim plugins

The VIM plugins are Git Submodules, managed through Pathogen.vim. Run the following
commands to sync these repositories:

```
git submodule init
git submodule sync
git submodule update
```

## Links

 * [Github: malte70/dotfiles](https://github.com/malte70/dotfiles)
 * [Github: malte70/scripts](https://github.com/malte70/scripts)
 * [abcde](https://abcde.einval.com/)
 * [conky](https://github.com/brndnmtthws/conky)
 * [ncmpcpp](http://rybczak.net/ncmpcpp/)
 * [Uzbl](http://www.uzbl.org/)
 * [vim](http://www.vim.org/)
 * [zsh](http://zsh.sourceforge.net/)

