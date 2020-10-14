# 
# .zsh/alias.zsh
#     Alias definitions
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015-2016 Malte Bublitz, https://malte70.github.io
# All rights reserved.
# 

# command aliases:
if [[ "$OSVARIANT" == "Arch" ]]; then
	if which yaourt &>/dev/null; then
		alias y=yaourt
		alias y-Syu="yaourt -Syu"
		alias y-Syuw="yaourt -Syuw"
		alias y-Qdt="yaourt -Qdt"
		alias y-Qo="yaourt -Qo"
	elif which trizen &>/dev/null; then
		alias y=trizen
		alias y-Syu="trizen -Syu"
		alias y-Syuw="trizen -Syuw"
		alias y-Qdt="trizen -Qdt"
		alias y-Qo="trizen -Qo"
	else
		alias y=pacman
		alias y-Syu="pacman -Syu"
		alias y-Syuw="pacman -Syuw"
		alias y-Qdt="pacman -Qdt"
		alias y-Qo="pacman -Qo"
	fi
elif [[ "$(uname -o)" == "Msys" ]]; then
	alias yaourt==pacman
	alias y="yaourt"
	alias y-Syu="yaourt -Syu"
	alias y-Syuw="yaourt -Syuw"
	alias y-Qdt="yaourt -Qdt"
	alias y-Qo="yaourt -Qo"
elif which pacapt &>/dev/null; then
	# If pacapt is installed, add some aliases.
	if [[ "$OS" == "Mac OS X" ]] && which brew &>/dev/null; then
		# On OS X with Homebrew, no sudo is needed
		alias yaourt==pacapt
		alias y="pacapt"
		alias y-Syu="pacapt -Syu"
		alias y-Syuw="pacapt -Syuw"
		alias y-Qo="pacapt -Qo"
	else
		alias yaourt="sudo pacapt"
		alias y="yaourt"
		alias y-Syu="y -Syu"
		alias y-Syuw="y -Syuw"
		alias y-Qo="pacapt -Qo"
	fi
fi
if [[ $OS != "Mac OS X" && $OS != "FreeBSD" ]]; then
	alias ls="`print -n =ls` --color=auto --escape -l --file-type -h --time-style=long-iso"
	alias l1="`print -n =ls` --color=auto --escape -1"
	alias du="`print -n =du` --summarize --total --human-readable"
	alias d=`print -n =date`' --rfc-3339=seconds | tr " " "T"'
	if [[ $OS != "Android" ]]; then
		alias df="`print -n =df` --human-readable --print-type"
	else
		# Termux's df command is not the GNU version, but an alternative
		# implementation from the termux-tools package
		alias df="`print -n =df` -h"
	fi
else
	if which gls &>/dev/null; then
		# If gls is available, all other coreutils should be too.
		alias ls="`print -n =gls` --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias l1="`print -n =gls` --color=auto --escape -1"
		alias df="`print -n =gdf` --human-readable --print-type"
		alias du="`print -n =gdu` --summarize --total --human-readable"
		alias d=`print -n =gdate`' --rfc-3339=seconds | tr " " "T"'
		alias sed="`print -n =gsed`"
	else
		alias ls="/bin/ls -l -G -F -b -h"
		alias l1="/bin/ls -1"
		alias df="/bin/df -h"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
	fi
fi
if [[ $OS == "Android" ]]; then
	stripwhite() {
		python -c 'import sys;print(sys.stdin.read(),end="")' | sed 's/^[ \t]*//;s/[ \t]*$//g' </dev/stdin
	}
fi
if which lsblk &>/dev/null; then
	alias disks="/bin/lsblk -o NAME,TYPE,FSTYPE,SIZE,LABEL,MOUNTPOINT"
fi
alias goyo="$(echo =vim) -c Goyo"
alias mem="free -m"
alias t==todo
g-i() {
	YEAR="$(date +%Y)"
	
	if [[ $# -ne 1 ]]
	then
		echo "Usage: $0 <reponame>" >&2
		exit 1
	elif [[ -d $1 ]]
	then
		echo "$0: Error: Directory $1 already exists!" >&2
		exit 1
	fi
	
	mkdir "$1"
	pushd "$1" &>/dev/null
	git init
	echo "# $1" > README.md
	wget -q 'https://raw.githubusercontent.com/malte70/moin/master/COPYING.md'
	sed -i "s/2015/$YEAR/g" COPYING.md
	
	git add README.md COPYING.md
	git commit -m 'Initial commit'
	
	popd &>/dev/null
}
alias g="git"
alias g-c="git clone"
alias g-p="git push --tags -u origin master"
alias g-t="git t"
alias g-d="git d"
alias g-ds="git ds"
alias tree="tree -AC"
alias zshrc-reload="source ~/.zshrc"
if which lsusb.py &>/dev/null
then
	alias lsusb.py="$(print =lsusb.py) -u -c"
fi
alias mkdir="mkdir -p"
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

# global aliases:
alias -g L="|$PAGER"
alias -g G='|grep'
alias -g Gv='|grep -v'
alias -g Gi='|grep -i'
alias -g GE='|grep -E'
alias -g GvE='|grep -v -E'
alias -g GEi='|grep -E -i'
alias -g GvEi='|grep -v -E -i'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|wc -l'
alias -g S='|stripwhite'
alias -g 2null='2>/dev/null'

# Alias for alsaequal (only if installed)
ALSAEQUAL_PLUGIN_PATH="/usr/lib/alsa-lib/libasound_module_ctl_equal.so"
if [[ -f ${ALSAEQUAL_PLUGIN_PATH} ]]
then
	alias alsaequal="alsamixer -D equal"
fi

if [[ $OS == "Mac OS X" ]]; then
	show_desktop() {
		doOrDont=$1
		if [[ $doOrDont == "yes" ]]; then
			doOrDont="true"
		elif [[ $doOrDont == "no" ]]; then
			doOrDont="false"
		fi
		defaults write com.apple.finder CreateDesktop -bool $doOrDont && killall -SIGHUP Finder
	}
fi

# GCC and G++ Wrapper with default options
if [[ $OS == "GNU/Linux" || $OS == "Mac OS X" ]]; then
	unalias gcc 2>/dev/null
	unalias g++ 2>/dev/null
	CC=$(which gcc)
	CXX=$(which g++)
	if [[ $OS == "Mac OS X" ]]; then
		# gcc is version 4 on my OS X 10.6 MacBook,
		# and doesn't support all of the options of
		# this alias, so use gcc 5 from Homebrew
		which gcc-5 &>/dev/null && CC=$(which gcc-5)
		which gcc-5 &>/dev/null && CXX=$(which g++-5)
	fi
	alias gcc="$CC -std=c11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -pedantic-errors -march=native -O3"
	alias g++="$CXX -std=c++11 -D_POSIX_C_SOURCE=200809L -Wall -Wextra -pedantic-errors -march=native -O3"
fi
alias firefox-list-profiles="$(which find) ~/.mozilla/firefox/ -type d -mindepth 1 -maxdepth 1 2>/dev/null | cut -d. -f3"

# Launch QEMU using qemu command
if which qemu-system-i386 &>/dev/null && ! which qemu &>/dev/null; then
	if [[ $CPUTYPE == "x86_64" ]]; then
		alias qemu==qemu-system-x86_64
	else
		alias qemu==qemu-system-i386
	fi
fi

# Launch GUI applications detched (Inspired by Windows...)
start() {
	$@ </dev/null &>/dev/null &|
}

if [[ $OS != "Mac OS X" ]]
then
	if [[ $OS == "Windows NT" ]] && [[ -e /dev/clipboard ]]
	then
		alias pbcopy="cat > /dev/clipboard"
		alias pbpaste="cat /dev/clipboard"
	elif which xsel &>/dev/null
	then
		alias pbcopy='xsel --clipboard --input'
		alias pbpaste='xsel --clipboard --output'
	elif [[ $OS == "Android" ]]
	then
		alias pbcopy='termux-clipboard-set'
		alias pbpaste='termux-clipboard-get'
	fi
fi

if which compass &>/dev/null
then
	alias mkcss="$(which compass) compile"
fi

# 
# Copy last command to clipboard
# 
# Needs working pbcopy (the original one OS X
# or the alias defined above)
# 
copy-last-commandline() {
	if which pbcopy &>/dev/null
	then
		history | tail -n1 | cut -c 6- | stripwhite | tr -d "\n" | pbcopy
	else
		echo "pbcopy not found. Please copy manually:"
		history | tail -n1 | cut -c 6- | stripwhite
	fi
}

# 
# mount-nas / umount-nas
# 
# Mounts/umounts all NAS shares
# 
# Note: Intended for usage at tardis.mcbx.de only.
# 
mount-nas() {
	for share in $(grep '^nas.*nfs' /etc/fstab | awk '{print $2}')
	do
		if grep $share /etc/mtab &>/dev/null
		then
			echo "${_ANSI_COLOR_LIGHT_YELLOW}[SKIP]$_ANSI_RESET $share"
		else
			echo "${_ANSI_COLOR_LIGHT_GREEN}[ OK ]$_ANSI_RESET $share"
			mount $share
		fi
	done
}
umount-nas() {
	for mount in $(grep /mnt/nas /etc/mtab | awk '{print $2}')
	do 
		if umount $mount &>/dev/null
		then
			echo "${_ANSI_COLOR_LIGHT_GREEN}[ OK ]$_ANSI_RESET Unmount $mount"      
		else    
			echo "${_ANSI_COLOR_LIGHT_RED}[FAIL]$_ANSI_RESET Unmount $mount"        
		fi
	done
}

if [[ $OS == "GNU/Linux" ]]
then
	if which colordiff &> /dev/null
	then
		_diff=$(which colordiff)
	else
		_diff=$(which diff)
	fi
	alias diff="${_diff} --color=auto -N -p -u -r -x .git"
	unset _diff
fi

if [[ "$(uname -o)" == "Msys" ]]
then
	alias python="/mingw32/bin/python3"
fi

# Add a ccat ("colored cat") alias with source code highlighting
# using `highlight`.
# See also: http://www.andre-simon.de/doku/highlight/highlight.html
if which highlight &>/dev/null; then
	if [[ $TERM == "xterm-256color" ]]; then
		alias ccat="$(which highlight) --tab=4 -O xterm256"
		
	elif [[ "$(tput colors 2>/dev/null)" -gt 2 ]]; then
		alias ccat="$(which highlight) --tab=4 -O ansi"
		
	else
		# Fallback for dummy terminals
		alias ccat="/bin/cat"
	fi
else
	# Don't let ccat fail if highlight is not available
	alias ccat="/bin/cat"
fi

