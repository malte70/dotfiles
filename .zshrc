#
# ~/.zshrc
#

# my network setup. used to adjust behaviour to specific host
LOCAL_DOMAIN="malte-bublitz.de"
SERVERS=(
	"ovis.flying-sheep.de"
	"khaos.kaos-miners.de"
	"deepthought.malte-bublitz.de"
)
DESKTOPS=(
	"sauron"    # main desktop
	"gallifrey" # notebook
	"placente"  # MacBook
)

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
PATH=${PATH}/home/malte/bin
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
	malte@{deepthought.malte-bublitz.de,khaos.khaos-miners.de,ovis.flying-sheep.de}
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
# set browser to elinks on servers, everywhere else to firefox.
node=`hostname -s`
if (( ${SERVERS[(i)$node]} <= ${#SERVERS} )); then
	BROWSER==elinks
else
	BROWSER==firefox
fi
MAIL=~/Mail
export EDITOR PAGER BROWSER MAIL

#
# Aliases
# 
# command aliases:
alias y=yaourt
alias y-Syu="yaourt -Syu"
alias y-Qdt="yaourt -Qdt"
alias ls="/usr/bin/ls --color=auto --escape -l --file-type -h --time-style=long-iso"
alias mem="free -m"
alias t="/home/malte/bin/todo.txt/todo.sh"
alias g-c="git clone"
# global aliases:
alias -g L='|most'
alias -g G='|grep'
alias -g Gi='|grep -i'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc -l'

# map STOP to ^W (START is ^Q, and also, ^S is free to be used by vim)
stty stop ^A

# prompt theme
get_git_prompt_info() {
	ping -c1 -W 1 91.194.91.73 &>/dev/null
	if [ $? -eq 1 ]; then
		UPSTREAM="!fail!"
	else
		CACHEFILE=~/.cache/git-info/`pwd | tr '/' '='`
		if [ -f $CACHEFILE ]; then
			UPSTREAM=`cat $CACHEFILE`
		else
			UPSTREAM=$(git remote show origin 2>/dev/null | head -n2 | tail -n1 | cut -d\  -f 6 | cut -d/ -f5 | cut -d\. -f1 | tr -d '\n')
			if [ -z $UPSTREAM ]
			then
				UPSTREAM="no git"
			else
				if [[ "$UPSTREAM" == "dotfiles" ]]
				then
					if [[ "$PWD" == "$HOME" ]]; then
						UPSTREAM="git:$UPSTREAM"
					else
						UPSTREAM="no git"
					fi
				else
					UPSTREAM="git:$UPSTREAM"
				fi
			fi
			echo -n $UPSTREAM > $CACHEFILE
		fi
	fi
	echo -n $UPSTREAM
}
get_return_prompt_info() {
	RET=$?
	if [ ! $RET -eq 0 ]; then
		echo -n "%F{cyan}[%F{red}$RET%F{cyan}]"
	fi
}
get_todo_prompt_info() {
	if [ -f TODO.md ]; then
		echo -n "local TODO: $(grep " \* " TODO.md | wc -l | tr -d '\n') items"
	else
		echo -n 'no local TODO'
	fi
}
get_global_todo_prompt_info() {
	echo -n "global TODO: "
	t list | tail -n1 | cut -d\  -f4 | tr -d '\n'
	echo -n " items"
}
setopt prompt_subst
PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B`uname -o`%b%F{cyan}|%F{green}%B`uname -r`%b%F{cyan}]%(?.. %F{cyan}[%F{red}%?%F{cyan}]) %F{yellow}%~%b%F{white}
%F{cyan}[%B%F{white}"'$(get_git_prompt_info)'"%b%F{cyan}] [%B%F{white}"'$(get_todo_prompt_info)'"%b%F{cyan}] [%B%F{white}"'$(get_global_todo_prompt_info)'"%b%F{cyan}]
%F{white}%n@%F{green}%m%F{white}$ "
#%F{green}`hostname -f`%F{white}$ "
RPROMPT="%B%F{yellow}%D{[%R] %a %Y-%m-%d}%b%F{white}"

# for mc:
[[ ! -z "$MC_SID" ]] && { PROMPT="%n@%m$ "; RPROMPT="" }
true

# show todo
echo "-= TODO =-"
t list | head -n-2
echo

