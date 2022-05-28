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
    * Ubuntu (tested on the most current LTS releases, inside KVM as well as on Windows Subsystem for Linux)
 * FreeBSD
 * macOS

### Software requirements of zsh configuration

Additional software that has to be installed

 * Python
 * Vim or NeoVim (soft requirement using EDITOR variable)
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

