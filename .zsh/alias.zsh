# 
# .zsh/alias.zsh
#     Alias definitions
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
elif [[ "$OSVARIANT" == "Msys" ]]; then
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
		alias trizen="sudo pacapt"
	fi
fi
if [[ $OS != "Mac OS X" && $OS != "FreeBSD" && $OS != "DragonFly BSD" ]]; then
	alias ls="`print -n =ls` --color=auto --escape -l --file-type -h --time-style=long-iso"
	alias la="`print -n =ls` --color=auto --escape -l --file-type -h --time-style=long-iso --almost-all"
	alias l1="`print -n =ls` --color=auto --escape -1"
	alias du="`print -n =du` --summarize --human-readable"
	alias d=`print -n =date`' --iso-8601=seconds'
	alias df="`print -n =df` --human-readable --print-type"
else
	if which gls &>/dev/null; then
		# If gls is available, all other coreutils should be too.
		alias ls="`print -n =gls` --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias ls="`print -n =gls` --color=auto --escape -l --file-type -h --time-style=long-iso --almost-all"
		alias l1="`print -n =gls` --color=auto --escape -1"
		alias df="`print -n =gdf` --human-readable --print-type"
		alias du="`print -n =gdu` --summarize --human-readable"
		alias d=`print -n =gdate`' --iso-8601=seconds'
		alias sed="`print -n =gsed`"
	else
		alias ls="/bin/ls -l -G -F -b -h"
		alias la="/bin/ls -l -G -F -b -h -A"
		alias l1="/bin/ls -1"
		alias df="/bin/df -h"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
	fi
fi

if [[ $OS == "GNU/Linux" ]]; then
	if which lsblk &>/dev/null; then
		alias disks="`print =lsblk` -o NAME,TYPE,FSTYPE,SIZE,LABEL,MOUNTPOINT"
		
	fi
	
elif [[ $OS == "FreeBSD" ]]; then
	if which lsblk &>/dev/null; then
		alias disks="lsblk"
	fi
	
elif [[ $OS == "Mac OS X" ]]; then
	alias disks="sudo diskutil list"
	
fi

alias goyo="$(echo =vim) -c Goyo"
alias mem="free -m"
alias t==todo
g-i() {
	YEAR="$(date +%Y)"
	AUTHOR="$(getent passwd $USER | cut -d: -f5)"
	
	if [[ $# -ne 1 ]]
	then
		echo "Usage: $0 [-c] <reponame> [<readme title>]" >&2
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
	echo "" > README.md
	
	# Create LICENSE from a template
	wget -q -O LICENSE "https://f.malte70.de/LICENSE.tpl"
	sed -i "s/%YEAR%/$YEAR/g" LICENSE
	sed -i "s/%AUTHOR%/$AUTHOR/g" LICENSE
	
	git add README.md LICENSE
	git commit -m 'Initial commit'
	
	popd &>/dev/null
}
alias g="git"
alias g-c="git clone"
alias g-p="g branch G main && g push --tags -u origin main || g push --tags -u origin master"
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
alias -g Snl='|tr -d "\n"'
alias -g 2null='2>/dev/null'
alias -g a2null='*>/dev/null'
alias -g X='|hexdump -C'

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
	for share in $(grep SynologyNAS /etc/fstab | grep -v ^# | awk '{print $2}')
	do
		if grep $share /etc/mtab &>/dev/null
		then
			echo "${_ANSI_COLOR_LIGHT_YELLOW}[SKIP]$_ANSI_RESET $share"
		else
			echo -ne "${_ANSI_COLOR_LIGHT_GREEN}[ OK ]$_ANSI_RESET $share"
			mount $share 2>/dev/null || sudo mount $share 2>/dev/null 
			if [[ $? -ne 0 ]]; then
				echo -e "\r${_ANSI_COLOR_LIGHT_RED}[FAIL]$_ANSI_RESET $share"
			else
				echo
			fi
		fi
	done
}
umount-nas() {
	for mount in $(grep /mnt/nas /etc/mtab | awk '{print $2}')
	do 
		if umount $mount &>/dev/null || sudo umount $mount &>/dev/null
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

if [[ "$OSVARIANT" == "Msys" ]]
then
	alias python="/mingw32/bin/python3"
fi

# Add a ccat ("colored cat") alias with source code highlighting
# using `highlight`.
# See also: http://www.andre-simon.de/doku/highlight/highlight.html
if which highlight &>/dev/null; then
	if [[ $TERM == "xterm-256color" ]]; then
		alias ccat="$(which highlight) --replace-tabs=4 -O xterm256"
		
	elif [[ "$(tput colors 2>/dev/null)" -gt 2 ]]; then
		alias ccat="$(which highlight) --replace-tabs=4 -O ansi"
		
	else
		# Fallback for dummy terminals
		alias ccat="/bin/cat"
	fi
else
	# Don't let ccat fail if highlight is not available
	alias ccat="/bin/cat"
fi

# Use alternative modern Unix utilities if available:
#   ls   -> eza/exa
#   tree -> eza/exa
#   cat  -> bat
#   df   -> duf
#   du   -> dust
if =which exa &>/dev/null; then
	alias ls="$(which exa) --long --header --group --time-style=long-iso --icons --group-directories-first"
	alias l1="$(which exa) -1"
	alias ll="ls --git --links"
	alias tree="$(which exa) --long --header -T --icons"
fi
if =which eza &>/dev/null; then
	alias ls="$(which eza) --long --header --group --time-style=long-iso --icons --group-directories-first"
	alias l1="$(which eza) -1"
	alias ll="ls --git --links"
	alias tree="$(which eza) --long --header -T --icons"
fi
if =which batcat &>/dev/null; then
	alias bat="$(which batcat) --paging=never"
	alias cat="batcat"
	alias ccat="batcat"
elif =which bat &>/dev/null; then
	alias bat="$(which bat) --paging=never"
	alias cat="bat"
	alias ccat="bat"
fi
if =which duf &>/dev/null; then
	alias df="$(which duf) -hide special,binds"
	alias duf="$(which duf) -hide special,binds"
fi
if =which dust &>/dev/null; then
	alias du="$(which dust)"
fi

# Use NeoVim if available
if which nvim &>/dev/null; then
	alias vim=$(which nvim)
fi

# On macOS, use the original `open`, not my implementation from
# <https://github.com/malte70/scripts> written for GNU/Linux and *BSD.
if [[ $OS == "Mac OS X" ]]; then
	alias open="/usr/bin/open"
fi

# Show basic information about the terminal
ttyinfo() {
	echo "==> Terminal Info"
	echo "TTY.: $TTY"
	echo "Type: $TERM"
	echo "Size: ${COLUMNS}x${LINES}"
}

# Alias to search the web using Google
# Uses ELinks if installed, and falls back to `open` from malte70/scripts
google() {
	q=$(echo -n $@ | python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.stdin.read()))")
	if which elinks &>/dev/null; then
		elinks "http://www.google.com/search?hl=de&q=${q}"
	else
		open "http://www.google.com/search?hl=de&q=${q}"
	fi
}


# Change terminal title
# https://tldp.org/HOWTO/pdf/Xterm-Title.pdf
set-xterm-title() {
	[[ $TERM == "dump" ]] && return
	print -Pn "\e]0;$1\a"
}
set-xterm-title "$USER@$HOST"


# Hide ffmpeg/ffprobe banner
if which ffmpeg &>/dev/null; then
	alias ffmpeg="`print =ffmpeg` -hide_banner"
	alias ffprobe="`print =ffprobe` -hide_banner"
fi

# Just
if which just &>/dev/null; then
	alias j="`print =just`"
fi

# 
# Find a password store entry matching a string
# 
findpass() {
	#pass ls | grep --before-context=3 --after-context=1 --ignore-case $@
	(
		cd "$HOME/.password-store" || return 1
		find . -iname "*${1}*.gpg" | sed 's/^\.//;s/\.gpg$//g'
	)
}

# Change to per-user temporary directory
cdtmp() {
	_usertmp="/tmp/$USER"
	[ -d "$_usertmp" ] || mkdir "$_usertmp"
	echo "pushd $_usertmp"
	pushd "$_usertmp" >&2
}


# 
# Create (touch) a file and create the parent directory if required
# 
mktouch() {
	while [[ $# -gt 0 ]]; do
		_dirname=$(dirname $1)
		if [[ ! -d "$_dirname" ]]; then
			mkdir -p "$_dirname"
		fi
		touch $1
		
		shift
	done
}


#
# FreeBSD version info
#
if [[ $OS == "FreeBSD" ]]; then
	sysinfo-freebsd-version() {
		echo
		echo "${_ANSI_COLOR_BLUE}==>${_ANSI_COLOR_WHITE} FreeBSD Version ${_ANSI_RESET}"
		echo

		echo -n "${_ANSI_COLOR_WHITE}Installed kernel:${_ANSI_RESET}
${_ANSI_COLOR_GREEN}"
		freebsd-version -k
		echo

		echo -n "${_ANSI_COLOR_WHITE}Running kernel:${_ANSI_RESET}
"
		if [[ "$(freebsd-version -k)" == "$(freebsd-version -r)" ]]; then
			echo -n "${_ANSI_COLOR_GREEN}"
		else
			echo -n "${_ANSI_COLOR_YELLOW}"
		fi
		freebsd-version -r
		echo

		echo -n "${_ANSI_COLOR_WHITE}Installed userland:${_ANSI_RESET}
${_ANSI_COLOR_GREEN}"
		freebsd-version -u
		echo

	}
fi


#
# ANSI Color Demo
#
ansicolordemo() {
	_color_demo_figfont="mini"
	_color_demo_title="ANSI Color Demo"
	
	clear
	if which figlet &>/dev/null
	then
		echo
		figlet \
			-f "${_color_demo_figfont}" \
			"${_color_demo_title}"      \
			| sed 's/^/	/'
		
	else
		echo -n "\t${_ANSI_COLOR_WHITE}# "
		echo -n "${_ANSI_ATTR_UNDERLINE}"
		echo -n "${_color_demo_title}"
		echo "${_ANSI_RESET}"
		
	fi
	
	echo; echo
	echo "\t_ANSI_RESET"
	echo "\t${_ANSI_ATTR_BOLD}_ANSI_ATTR_BOLD${_ANSI_RESET}                                       _ANSI_ATTR_BOLD_RESET"
	echo "\t${_ANSI_ATTR_ITALIC}_ANSI_ATTR_ITALIC${_ANSI_RESET}                                   _ANSI_ATTR_ITALIC_RESET"
	echo "\t${_ANSI_ATTR_UNDERLINE}_ANSI_ATTR_UNDERLINE${_ANSI_RESET}                             _ANSI_ATTR_UNDERLINE_RESET"
	echo "\t${_ANSI_ATTR_STRIKETHROUGH}_ANSI_ATTR_STRIKETHROUGH${_ANSI_RESET}                     _ANSI_ATTR_STRIKETHROUGH_RESET"
	echo "\t${_ANSI_ATTR_INVERSE}_ANSI_ATTR_INVERSE${_ANSI_RESET}                                 _ANSI_ATTR_INVERSE_RESET"
	echo "\t${_ANSI_ATTR_BLINKING}_ANSI_ATTR_BLINKING${_ANSI_RESET}                               _ANSI_ATTR_BLINKING_RESET"
	#echo "\t${_ANSI_ATTR_HIDDEN}_ANSI_ATTR_HIDDEN${_ANSI_RESET}                                   _ANSI_ATTR_HIDDEN_RESET"
	echo "\t_ANSI_ATTR_CURSOR_VISIBLE                          _ANSI_ATTR_CURSOR_HIDDEN"
	echo "\t_ANSI_ATTR_SCREEN_SAVE                            _ANSI_ATTR_SCREEN_RESTORE"
	echo "\t_ANSI_ATTR_ALTERNATE_BUFFER_ENABLED    _ANSI_ATTR_ALTERNATE_BUFFER_DISABLED"
	echo
	echo "\t${_ANSI_COLOR_BLACK}_ANSI_COLOR_BLACK${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_GREY}_ANSI_COLOR_BLACK${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_RED}_ANSI_COLOR_RED${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_GREEN}_ANSI_COLOR_GREEN${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_YELLOW}_ANSI_COLOR_YELLOW${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_BLUE}_ANSI_COLOR_BLUE${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_DARK_MAGENTA}_ANSI_COLOR_DARK_MAGENTA${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_DARK_CYAN}_ANSI_COLOR_DARK_CYAN${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_GREY}_ANSI_COLOR_GREY${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_DARK_GREY}_ANSI_COLOR_DARK_GREY${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_LIGHT_RED}_ANSI_COLOR_LIGHT_RED${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_LIGHT_GREEN}_ANSI_COLOR_LIGHT_GREEN${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_LIGHT_YELLOW}_ANSI_COLOR_LIGHT_YELLOW${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_LIGHT_BLUE}_ANSI_COLOR_LIGHT_BLUE${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_MAGENTA}_ANSI_COLOR_MAGENTA${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_CYAN}_ANSI_COLOR_CYAN${_ANSI_RESET}"
	echo "\t${_ANSI_COLOR_WHITE}_ANSI_COLOR_WHITE${_ANSI_RESET}"
	echo
}


# 
# gpa: Open the key manager by default
# 
gpa() {
	if [[ $# -eq 0 ]]; then
		1="--keyring"
	fi
	=gpa $@
}



