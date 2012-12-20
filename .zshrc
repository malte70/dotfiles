#
# ~/.zshrc
#

# History: 10,000 lines in ~/.histfile
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

eval `dircolors -b`
setopt autocd
setopt noclobber
unsetopt beep notify

# path
PATH=""
PATH=${PATH}/bin:
PATH=${PATH}/sbin:
PATH=${PATH}/usr/bin:
PATH=${PATH}/usr/sbin:
PATH=${PATH}/usr/local/bin:
PATH=${PATH}/usr/local/sbin:
PATH=${PATH}/usr/bin/vendor_perl:
PATH=${PATH}/opt/java/jre/bin:
PATH=${PATH}$(ruby -rubygems -e "puts Gem.user_dir")/bin":
PATH=${PATH}/home/malte/bin"
export PATH

# vi keybindings
bindkey -v
# convert ~/.inputrc into bindkey calls to get keys like [Home] working as expected
eval "$(sed -n 's/^/bindkey /; s/: / /p' ~/.inputrc)"
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
	malte@{deepthought,sauron,nal-hutta,inferi,nebuchadnezzar}{,.malte-bublitz.de}
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
PAGER==most
BROWSER==chromium
MAIL=~/Mail
export EDITOR PAGER BROWSER MAIL

#
# Aliases
# 
# command aliases:
alias y=yaourt
alias ySyu="yaourt -Syu"
alias yQdt="yaourt -Qdt"
alias ls='/bin/ls --color=auto --escape -l --file-type -h --time-style=long-iso'
alias mem="free -m"
# SSH aliases
alias shdeep="ssh deepthought.malte-bublitz.de"
alias shnalh="ssh nal-hutta.malte-bublitz.de"
alias shnebu="ssh nebuchadnezzar.malte-bublitz.de"
alias shifri="ssh inferi.malte-bublitz.de"
# global aliases:
alias -g L='|most'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc -l'
# suffix aliases:
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s de=$BROWSER
alias -s png==gpicview
alias -s jpg==gpicview
alias -s jpeg==gpicview
alias -s gif==gpicview
alias -s odt==libreoffice
alias -s ods==libreoffice
alias -s doc==libreoffice
alias -s docx==libreoffice
alias -s xls==libreoffice
alias -s xlsx==libreoffice

# map STOP to ^W (START is ^Q, and also, ^S is free to be used by vim)
stty stop ^A

# prompt theme
get_git_prompt_info() {
	UPSTREAM=$(git remote show origin 2>/dev/null | head -n2 | tail -n1 | cut -d\  -f 6 | cut -d/ -f5 | cut -d\. -f1 | tr -d '\n')
	if [ -z $UPSTREAM ]
	then
		echo -n "no git"
	else
		if [[ "$UPSTREAM" == "dotfiles" ]]
		then
			[[ "$PWD" == "$HOME" ]] || echo -n "no git"
		else
			echo -n "git:$UPSTREAM"
		fi
	fi
}
setopt prompt_subst
PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B`uname -o`%b%F{cyan}|%F{green}%B`uname -r`%b%F{cyan}] %F{cyan}[%B%F{white}"'$(get_git_prompt_info)'"%b%F{cyan}] %F{yellow}%~%b%F{white}
%F{white}%n@%F{green}%m%F{white}$ "
#%F{green}`hostname -f`%F{white}$ "
RPROMPT="%B%F{yellow}%D{[%R] %a %Y-%m-%d}%b%F{white}"


# start ssh-agent
if [ "x${SSH_AGENT_PID}" = "x" ] #-a "x${SSH_TTY}" != "x" ]
then
	eval `ssh-agent` >/dev/null
fi

# for mc:
[[ ! -z "$MC_SID" ]] && { PROMPT="%n@%m$ "; RPROMPT="" }
