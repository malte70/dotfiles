# vim: set ft=zsh:
# 
# ~/.bashrc
#    Used for NON-login shells (X11 Terminals)
# 
# Part of:
#    https://github.com/malte70/dotfiles
# 


# 
# Environment variables
# 
OS=$(uname -s)
if [[ "$OS" == "Darwin" ]]; then
	OS="macOS"
	
elif [[ "$(uname -o)" == "Msys" ]]; then
	# Msys2 on Windows NT
	OS=$(uname -o)
	
elif echo $SHELL | grep "com.termux" &> /dev/null
then
	# Termux on Android
	OS="Android"
	
fi

# Ensure $HOSTNAME and $HOST are both set and have the same value.
[[ -z $HOST && -n $HOSTNAME ]] && export HOST=$HOSTNAME

# Default Editor/Browser
# NOTE: You might want to set $VISUAL to a GUI application
#       in your .bashrc.local.
EDITOR=$(which vim)
VISUAL=$EDITOR
if [[ $OS == "macOS" ]]; then
	# Use open(1)
	BROWSER="/usr/bin/open"
elif [[ -z $DISPLAY ]]; then
	# No X11 display available
	which elinks &>/dev/null && BROWSER=$(which elinks)
else
	# Use xdg-open(1) on X11
	BROWSER=$(which xdg-open)
fi
# Use less(1) as default pager, with the "-R" option
# (Which shows ANSI color codes and OSC 8 hyperlinks in
# their raw form)
PAGER="less"
LESS="-R"
export BROWSER EDITOR PAGER LESS


# 
# Don't run anything below on non-interactive sessions
# 
if [[ -z "$PS1" ]]
then
	return
fi


# 
# Set prompt from a list of hard-coded themes
# 
. $HOME/.bash_prompt


# 
# Add ~/bin and ~/.local/bin to $PATH if they exist.
# 
if [[ -d "${HOME}/bin" ]]; then
	echo $PATH | grep -q "${HOME}/bin" || PATH="${HOME}/bin:${PATH}"
fi
if [[ -d "${HOME}/.local/bin" ]]; then
	echo $PATH | grep -q "${HOME}/.local/bin" || PATH="${HOME}/.local/bin:${PATH}"
fi


# 
# OS specific aliases etc.
# 
case $OS in
	"Linux")
		# GNU/Linux
		OS="$(uname -o)"
		OSVER="$(uname -r)"
		DIST=$(grep DESCRIPTION /etc/lsb-release 2>/dev/null | cut -d\" -f2 || lsb_release --short --description)
		[ "x" == "x$DIST" ] && DIST="Unknown"
		
		prompt "linux"
		
		alias ..="cd .."
		alias ls="$(which ls) --color=auto --escape --file-type -h --time-style=long-iso"
		alias ll="$(which ls) --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="$(which df) --human-readable --print-type"
		alias d='date --rfc-3339=seconds | tr " " "T"'
		;;
		
	"macOS")
		# macOS
		OSVER="$(python3 -c 'import platform; print(platform.mac_ver()[0])')"
		DIST="macOS $OSVER"
		
		prompt "macos"
		
		alias ..="cd .."
		alias ls="/bin/ls -G -F -b -h"
		alias ll="/bin/ls -l -G -F -b -h"
		alias df="/bin/df -h"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
		;;
		
	"Msys")
		# Msys on Windows NT
		OS="Windows NT"
		OSVER=$(uname -s | cut -d- -f2)
		DIST="$OS $OSVER"
		
		# Set $DIST for some known NT versions
		case $OSVER in
			"5.1")
				DIST="Windows XP";;
			"5.2")
				DIST="Windows 2003";;
			"6.0")
				# Vista or 2008
				DIST="Windows Vista";;
			"6.1")
				# 7 or 2008 R2
				DIST="Windows 7";;
			"6.2")
				# 8 or 2012
				DIST="Windows 8";;
			"6.3")
				# 8.1 or 2012 R2
				DIST="Windows 8.1";;
			"6.4"|"10.0")
				DIST="Windows 10";;
		esac
		
		PATH=""
		if [[ -d "${HOME}/bin" ]]; then
			PATH="${HOME}/bin:"
		fi
		PATH="${PATH}/mingw32/bin"
		PATH="${PATH}:/usr/bin:/bin"
		PATH="${PATH}:/c/Windows/system32"
		PATH="${PATH}:/c/Windows"
		export PATH
		
		prompt "nt"
		
		alias ..="cd .."
		alias ls="$(which ls) --color=auto --escape --file-type -h --time-style=long-iso"
		alias ll="$(which ls) --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="$(which df) --human-readable --print-type"
		alias d='date --rfc-3339=seconds | tr " " "T"'
		;;
		
	*)
		echo "Error: Only GNU/Linux, OS X and Msys/Windows NT are supported yet." >&2
		;;
esac

# 
# OS independent aliases
# 
. $HOME/.bash_aliases

# Define $PYTHONSTARTUP. See python(1) for details
PYTHONSTARTUP="$HOME/.pythonstartup"
if [[ -f "$PYTHONSTARTUP" ]]; then
	export PYTHONSTARTUP
else
	unset PYTHONSTARTUP
fi

# libgl on GWSL
if [[ $OSVERSION == *WSL* ]]; then
	export LIBGL_ALWAYS_INDIRECT=1
fi

[ -f $HOME/.bashrc.local ] && . $HOME/.bashrc.local; true
