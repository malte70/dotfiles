# 
# .zsh/alias.zsh
#     Alias definitions
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

# command aliases:
if [[ "$OSVARIANT" == "Arch" ]]; then
	alias y=yaourt
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
	alias df="`print -n =df` --human-readable --print-type"
	alias du="`print -n =du` --summarize --total --human-readable"
	alias d=`print -n =date`' --rfc-3339=seconds | tr " " "T"'
else
	if which gls &>/dev/null; then
		# If gls is available, all other coreutils should be too.
		alias ls="`print -n =gls` --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="`print -n =gdf` --human-readable --print-type"
		alias du="`print -n =gdu` --summarize --total --human-readable"
		alias d=`print -n =gdate`' --rfc-3339=seconds | tr " " "T"'
		alias sed="`print -n =gsed`"
	else
		alias ls="/bin/ls -l -G -F -b -h"
		alias df="/bin/df -h"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
	fi
fi
alias goyo="$(echo =vim) -c Goyo"
alias mem="free -m"
if which todo.sh &>/dev/null
then
	alias t==todo.sh
fi
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

# System update function
update () {
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} pushd <- \$HOME ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
	pushd $HOME >/dev/null
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} git pull @ malte70/dotfiles ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
	git pull
	git submodule init >/dev/null
	git submodule sync >/dev/null
	git submodule update >/dev/null
	if [[ -d $HOME/scripts ]]; then
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} pushd <- \$HOME/scripts ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
		pushd $HOME/scripts >/dev/null
	else
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} pushd <- \$HOME/bin ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
		pushd $HOME/bin >/dev/null
	fi
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} git pull @ malte70/scripts ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
	git pull
	popd >/dev/null
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} popd ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
	popd >/dev/null
	echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} popd ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
	
	if [[ $OS == "GNU/Linux" ]]; then
		if [[ $OSVARIANT == "Arch" ]]; then
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} ArchLinux :: Upgrade ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			y-Syu --aur
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} ArchLinux :: Cleanup ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			y -Qqdt &>/dev/null && y -R $(y -Qqdt)
			
		elif [[ $OSVARIANT == "Debian" || $OSVARIANT == "Ubuntu" ]]; then
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} $OSVARIANT :: Update ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			sudo apt-get update
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} $OSVARIANT :: Upgrade ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			sudo apt-get upgrade
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} $OSVARIANT :: Dist-Upgrade ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			sudo apt-get dist-upgrade
			echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} $OSVARIANT :: Cleanup ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
			sudo apt-get autoremove
		fi
	elif [[ $OS == "Mac OS X" ]]; then
		echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} Homebrew :: Update ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
		brew update
		echo "${_ANSI_COLOR_DARK_CYAN}==[${_ANSI_COLOR_LIGHT_GREEN} Homebrew :: Upgrade ${_ANSI_COLOR_DARK_CYAN}]==${_ANSI_RESET}"
		brew upgrade --all
	fi
	# Make sure $? equals 0
	true
}
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
	$@ </dev/null >/dev/null &|
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
	fi
fi

if which compass &>/dev/null
then
	alias mkcss="$(which compass) compile"
fi
