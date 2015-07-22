#!/bin/zsh
#
# Aliases
# 
# command aliases:
if [[ "$OS" == "Mac OS X" ]] && which pacapt &>/dev/null; then
	# On OS X, pacapt is used
	alias yaourt==pacapt
	alias y="pacapt"
	alias y-Syu="pacapt -Syu"
	alias y-Syuw="pacapt -Syuw"
elif [[ "$OSVARIANT" == "Arch" ]]; then
	alias y=yaourt
	alias y-Syu="yaourt -Syu"
	alias y-Syuw="yaourt -Syuw"
	alias y-Qdt="yaourt -Qdt"
fi
if [[ $OS != "Mac OS X" && $OS != "FreeBSD" ]]; then
	alias ls="`print -n =ls` --color=auto --escape -l --file-type -h --time-style=long-iso"
	alias df="`print -n =df` --human-readable --print-type"
	alias d=`print -n =date`' --rfc-3339=seconds | tr " " "T"'
else
	if which gls &>/dev/null; then
		# If gls is available, all other coreutils should be too.
		alias ls="`print -n =gls` --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="`print -n =gdf` --human-readable --print-type"
		alias d=`print -n =gdate`' --rfc-3339=seconds | tr " " "T"'
		alias sed="`print -n =gsed`"
	else
		alias ls="/bin/ls -l -G -F -b -h"
		alias df="/bin/df -h"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
	fi
fi
alias mem="free -m"
if which todo.sh &>/dev/null
then
	alias t==todo.sh
fi
alias g-c="git clone"
alias g-p="git push --tags -u origin master"
alias tree="tree -AC"
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
	pushd $HOME >/dev/null
	git pull
	git submodule init
	git submodule sync
	git submodule update
	if [[ -d $HOME/scripts ]]; then
		pushd $HOME/scripts >/dev/null
	else
		pushd $HOME/bin >/dev/null
	fi
	git pull
	popd >/dev/null
	popd >/dev/null
	if [[ $OS == "GNU/Linux" ]]; then
		if [[ $OSVARIANT == "Arch" ]]; then
			y-Syu --aur
			y -Qqdt &>/dev/null && y -R $(y -Qqdt)
		elif [[ $OSVARIANT == "Debian" || $OSVARIANT == "Ubuntu" ]]; then
			sudo apt-get update
			sudo apt-get upgrade
			sudo apt-get dist-upgrade
			sudo apt-get autoremove
		fi
	elif [[ $OS == "Mac OS X" ]]; then
		brew update
		brew upgrade --all
	fi
}
