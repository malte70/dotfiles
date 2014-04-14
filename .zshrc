#
# ~/.zshrc
#

# my network setup. used to adjust behaviour to specific host
LOCAL_DOMAIN="malte-bublitz.de"
SERVERS=(
	"ovis.flying-sheep.de"
	"khaos.kaos-miners.de"
	"deepthought.malte-bublitz.de"
	"khaos.malte70.de"
)
DESKTOPS=(
	"sauron"    # main desktop
	"gallifrey" # notebook
	"placente"  # MacBook
)

OS=`uname -s`
OSVERSION=`uname -r`
if [[ "$OS" == "Darwin" ]]; then
	OS="Mac OS X"
	OSVARIANT=$OS
	OSXVersion=`python -c 'import platform; print platform.mac_ver()[0],'`
	OSVERSION=$OSXVersion
else
	OS=`uname -o`
	if which lsb_release &>/dev/null; then
		OSVARIANT=`lsb_release -s -i`
	else
		OSVARIANT=$OS
	fi
	OSVERSION=`uname -r`
fi

# History: 10,000 lines in ~/.histfile
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

if which dircolors &>/dev/null; then
	# On OS X, there is no dircolors, but it is not needed
	eval `dircolors -b`
fi
setopt autocd
setopt noclobber
unsetopt beep notify

# path
PATH=""
PATH=${PATH}${HOME}/bin:  # allow me to overwrite scripts installed by packages
[ -d "${HOME}/scripts" ] && PATH=${PATH}${HOME}/scripts: # on some hosts, ~/bin is not my github repository malte70/scripts, it is in ~/scripts.
PATH=${PATH}/bin:
PATH=${PATH}/sbin:
PATH=${PATH}/usr/bin:
PATH=${PATH}/usr/sbin:
PATH=${PATH}/usr/local/bin:
PATH=${PATH}/usr/local/sbin:
PATH=${PATH}/usr/bin/core_perl:
PATH=${PATH}/usr/bin/vendor_perl:
PATH=${PATH}/opt/java/jre/bin:
[ -d "/opt/android-sdk/platform-tools" ] && PATH=${PATH}/opt/android-sdk/platform-tools:
export PATH

# vi keybindings
bindkey -v
# basic key bindings (portable, based on zsh article in the Official Arch Wiki)
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# allow backward history search including regexp using ^R (like known from GNU bash)
bindkey "^R" history-incremental-pattern-search-backward

# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
my_accounts=(
	malte@sauron.malte-bublitz.de
	malte@ovis.flying-sheep.de
	malte@deepthought.malte-bublitz.de
	malte70@abyss.malte-bublitz.de
	malte70@khaos.malte70.de
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
autoload -Uz compinit
compinit
autoload -U _requested _normal _setup _tags _next_label _path_files _parameters _wanted _set_command _suffix_alias_files
autoload -U _vim
autoload -U _sudo
autoload -U _ssh
autoload -U _source
autoload -U _tar
autoload -U _tar_archive
autoload -U _typeset

# define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

# just type 'cd ...' to get 'cd ../..'
rationalise-dot() {
  if [[ $LBUFFER == *.. ]] ; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# Allow comments even in interactive shells
setopt interactivecomments

# default browser and editor
EDITOR==vim
if which most &>/dev/null; then
	PAGER==most
else
	PAGER==less
fi
# set browser to elinks on servers, everywhere else to firefox.
node=`hostname -s`
if (( ${SERVERS[(i)$node]} <= ${#SERVERS} )); then
	BROWSER==elinks
elif [ $OS != "Mac OS X" ]; then
	BROWSER==firefox
else
	BROWSER="/Applications/Firefox.app/Contents/MacOS/firefox"
fi
if [ -d $HOME/Mail ]; then
	export MAIL=~/Mail
fi
export EDITOR PAGER BROWSER

#
# Aliases
# 
# command aliases:
if [[ "$OS" == "Mac OS X" ]]; then
	# On OS X, pacapt is used
	alias y=pacman
	alias y-Syu="pacman -Syu"
	alias y-Syuw="pacman -Syuw"
elif [[ "$OSVARIANT" == "Arch" ]]; then
	alias y=yaourt
	alias y-Syu="yaourt -Syu"
	alias y-Syuw="yaourt -Syuw"
	alias y-Qdt="yaourt -Qdt"
fi
if [[ $OS != "Mac OS X" ]]; then
	alias ls="`print -n =ls` --color=auto --escape -l --file-type -h --time-style=long-iso"
else
	alias ls="ls -l -G -F -b -h"
fi
alias mem="free -m"
if which todo.sh &>/dev/null
then
	alias t==todo.sh
fi
alias g="git"
alias g-c="git clone"
alias tree="tree  -AC"
# global aliases:
alias -g L="|$PAGER"
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc -l'

# map STOP to ^W (START is ^Q, and also, ^S is free to be used by vim)
stty stop ^A

# prompt theme
get_git_prompt_info() {
	UPSTREAM=`gitinfo`
	if [[ $UPSTREAM != "no git" ]]; then
		echo -n "%F{cyan}[%B%F{white}${UPSTREAM}%b%F{cyan}] "
	fi
}
setopt prompt_subst
precmd() {
	print -Pn "\e]0;%~ (%n@%m)\a"
}
preexec() {
	CMD=`echo $1 | cut -d" " -f1`
	if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
		print -Pn "\e]0;%~ (%n@%m) ($CMD)\a"
	fi
}
if [[ $OS == "Mac OS X" ]]; then
	PROMPT="]0;$HOST: $PWD" # ^G = BEL
else
	PROMPT=""
fi
PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B$OS%b%F{cyan}|%F{green}%B$OSVERSION%b%F{cyan}]%(?.. %F{cyan}[%F{red}%?%F{cyan}]) "'$(get_git_prompt_info)'"%F{yellow}%~%b%F{white}
%F{white}%n@%F{green}%m%F{white}$ "

# for mc:
[[ ! -z "$MC_SID" ]] && { PROMPT="%n@%m$ "; RPROMPT="" }
true

[ -f $HOME/.mc/solarized.ini ] && export MC_SKIN=$HOME/.mc/solarized.ini

start_autossh() {
	autossh -M 0 -q -f -N -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" -D 8081 sshtunnel@abyss.malte-bublitz.de
}
set_proxy() {
	case $1 in
		"sshtunnel")
			unset http_proxy
			unset https_proxy
			unset ftp_poxy
			export all_proxy=socks://127.0.0.1:1080
			;;
		"sshtunnel8080")
			unset http_proxy
			unset https_proxy
			unset ftp_poxy
			export all_proxy=socks://127.0.0.1:8080
			;;
		*)
			unset http_proxy
			unset https_proxy
			unset ftp_poxy
			unset all_proxy
			;;
	esac
}
# show todo, if logging in
# i know, this code is terrible...
if which todo.sh &>/dev/null
then
	[ -z $SHOW_TODO ] && SHOW_TODO="yes"
	if [ $SHOW_TODO != "no" -a "$(t list | wc -l)" -ne 2 ]; then
	echo "-= TODO =-"
	t list | head -n-2 | sort
	echo
	fi
	SHOW_TODO="no"
fi
