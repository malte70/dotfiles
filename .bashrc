# 
# ~/.bashrc
#    Used for NON-login shells (X11 Terminals)
# 
# Part of:
#    https://github.com/malte70/dotfiles
# 

CLR0="\[\033[0m\]"
CLR1="\[\033[0;36m\]"
CLR2_root="\[\033[1;31m\]"
CLR2_normal="\[\033[0;32m\]"
if [ $UID -eq 0 ]; then
	CLR2=$CLR2_root
	PROMPT_END="#"
else
	CLR2=$CLR2_normal
	PROMPT_END="$"
fi
CLR3="\[\033[1;32m\]"

OS=$(uname -s)

if [[ "$(uname -o)" == "Msys" ]]
then
	# Msys2 on Windows NT
	OS=$(uname -o)
elif echo $SHELL | grep "com.termux" &> /dev/null
then
	# Termux on Android
	OS="Android"
fi

if [[ -z "$PS1" ]]
then
	exit
fi

# Those mixed-case hostnames on Windows suck...
HOSTNAME_LOWER=$(hostname | tr 'A-Z' 'a-z')

# Detect hostname on Android
if [[ $OS == "Android" ]]
then
	HOSTNAME_ANDROID=$(getprop net.hostname)
	if [[ -z "$HOSTNAME_ANDROID" ]]
	then
		# No hostname set - fall back to devicename
		HOSTNAME_ANDROID=$(getprop ro.product.device)
	fi
fi

export PROMPT_LINUX="\u$CLR1@$CLR2\h$CLR0:$CLR3\w$CLR1$PROMPT_END $CLR0"
export PROMPT_OSX="$CLR1[$CLR0\u@$CLR2\h$CLR0 $CLR3\w$CLR1]${PROMPT_END}${CLR0} "
export PROMPT_ANDROID="${CLR1}${HOSTNAME_ANDROID}${CLR0}:[${CLR1}\w${CLR0}]\n${CLR2}\$${CLR0} "
export PROMPT_NT="$CLR1[$CLR0\u@${CLR2}${HOSTNAME_LOWER}$CLR0 $CLR3\w$CLR1]${PROMPT_END}${CLR0} "

case $OS in
	"Linux")
		# GNU/Linux
		OS="$(uname -o)"
		OSVER="$(uname -r)"
		DIST=$(grep DESCRIPTION /etc/lsb-release 2>/dev/null | cut -d\" -f2)
		[ "x" == "x$DIST" ] && DIST="Unknown"
		
		export PS1="${PROMPT_LINUX}"
		
		alias ..="cd .."
		alias ls="$(which ls) --color=auto --escape --file-type -h --time-style=long-iso"
		alias ll="$(which ls) --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="$(which df) --human-readable --print-type"
		alias d='date --rfc-3339=seconds | tr " " "T"'
		;;
		
	"Android")
		# Android/Termux
		OSVER="Linux-$(uname -r)"
		DIST="Termux"
		
		export TERMUX_ROOT="/data/data/com.termux/files"
		export PS1="${PROMPT_ANDROID}"
		export PATH="${TERMUX_ROOT}/usr/bin:${TERMUX_ROOT}/usr/bin/applets:${HOME}/bin"

		alias ..="cd .."
		alias ls="$(which ls) --color=auto --escape --file-type -h --time-style=long-iso"
		alias ll="$(which ls) --color=auto --escape -l --file-type -h --time-style=long-iso"
		alias df="$(which df) --human-readable --print-type"
		alias d='date --rfc-3339=seconds | tr " " "T"'
		;;
		
	"Darwin")
		# (Mac) OS X
		OS="Darwin"
		OSVER="$(uname -r)"
		DIST="OS X $(/usr/bin/python -c 'import platform; print platform.mac_ver()[0]')"
		
		export PS1="${PROMPT_OSX}"
		
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
		
		export PS1="${PROMPT_NT}"
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

if which mc &>/dev/null; then
	if [[ -f ~/.mc/solarized.ini ]]; then
		export MC_SKIN=$HOME/.mc/solarized.ini
	fi
fi

[ -f $HOME/.bashrc.local ] && . $HOME/.bashrc.local; true
