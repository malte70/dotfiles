# 
# .bash_aliases
# 
# Some OS-independent bash aliases. For OS-specific
# aliases see ´.bashrc´.
# NOTE: My Raspberry Pi 1 is the only computer on
# which I use bash instead of zsh. This file only
# contains those zsh-aliases I need there too.
# 

alias mem="free -m"
alias t="todo"
alias g="git"
alias g-c="git clone"
alias g-p="g branch G main && g push --tags -u origin main || g push --tags -u origin master"
alias g-t="git t"
alias g-d="git d"
alias g-ds="git ds"
alias tree="tree -AC"
alias mkdir="mkdir -p"



# 
# pacapt: pacman/trizen aliases
# 
if which pacapt &>/dev/null; then
	alias pacman="$(which pacapt)"
	alias trizen="sudo $(which pacapt)"
fi



# 
# disks: lsblk/diskutil
# 
if [[ $OS == "GNU/Linux" ]]; then
	if which lsblk &>/dev/null; then
		alias disks="$(which lsblk) -o NAME,TYPE,FSTYPE,SIZE,LABEL,MOUNTPOINT"
	fi
elif [[ $OS == "FreeBSD" ]]; then
	if which lsblk &>/dev/null; then
		alias disks="$(which lsblk)"
	fi
elif [[ $OS == "Mac OS X" ]]; then
	alias disks="sudo diskutil list"
fi



# 
# mkcd: mkdir+cd
# 
mkcd () {
	_d="$1"
	if [[ -e "$_d" ]]
	then
		if [[ ! -d "$_d" ]]
		then
			echo "mkcd: Error: Non-directory $_d already exists" >&2
		else
			cd "$_d"
		fi
	else
		mkdir "$_d"
		if [[ $? -ne 0 ]]
		then
			echo "mkcd: Could not create $_d" >&2
		else
			cd "$_d"
		fi
	fi
}



# 
# Use alternative modern Unix utilities if available:
#   ls   -> exa
#   tree -> exa
#   cat  -> bat
#   df   -> duf
#   du   -> dust
# 
if which exa &>/dev/null; then
	alias ls="$(which exa) --long --header --group --time-style=long-iso --icons"
	alias l1="$(which exa) -1"
	alias ll="ls --git --links"
	alias tree="$(which exa) --long --header -T --icons"
fi
if which bat &>/dev/null; then
	alias bat="$(print -n =bat) --paging=never"
	alias cat="bat"
	alias ccat="bat"
fi
if which duf &>/dev/null; then
	alias df="$(which duf) -hide special"
	alias duf="$(which duf) -hide special"
fi
if which dust &>/dev/null; then
	alias du="$(which dust)"
fi



# 
# On macOS, use the original `open`, not my implementation from
# <https://github.com/malte70/scripts> written for GNU/Linux and *BSD.
# 
if [[ $OS == "macOS" ]]; then
	alias open="/usr/bin/open"
fi



# 
# Alias to search the web using Google
# Uses ELinks if installed, and falls back to `open` from malte70/scripts
# 
google() {
	q=$(echo -n $@ | python -c "import urllib.parse,sys;print(urllib.parse.quote(sys.stdin.read()))")
	if which elinks &>/dev/null; then
		elinks "http://www.google.com/search?hl=de&q=${q}"
	else
		open "http://www.google.com/search?hl=de&q=${q}"
	fi
}



# 
# Change terminal title
# https://tldp.org/HOWTO/pdf/Xterm-Title.pdf
# 
set-xterm-title() {
	printf "\e]0;$1\a"
}



# 
# Python: When no "python" was found in $PATH, create an
# alias.
# 
if ! which python &>/devknulkl; then
	alias python="$(which python3)"
	alias pip="$(which pip3)"
	alias pydoc="$(which pydoc3)"
fi
