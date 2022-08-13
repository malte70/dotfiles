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
		alias disks="lsblk"
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
