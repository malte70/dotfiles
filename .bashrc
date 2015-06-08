#
# Maltes bashrc
#  If I work on someone else's computer...
#

#
# Basic (usable!) Prompt
# Examples:
#
#   Variant 0 (Default on GNU/Linux):
#     malte70@guest-pc:/etc$ _
#   Variant 1 (Default on OS X):
#     [malte70@guest-mac /Volumes]$ _
#

echo "Loading malte70's .bashrc ..."

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


export PROMPT_LINUX="\u$CLR1@$CLR2\h$CLR0:$CLR3\w$CLR1$PROMPT_END $CLR0"
export PROMPT_OSX="$CLR1[$CLR0\u@$CLR2\h$CLR0 $CLR3\w$CLR1]${PROMPT_END}${CLR0} "

OS=$(uname -s)

case $OS in
	"Linux")
		# GNU/Linux
		OS="$(uname -o)"
		OSVER="$(uname -r)"
		DIST=$(grep DESCRIPTION /etc/lsb-release 2>/dev/null | cut -d\" -f2)
		[ -z $DIST ] && DIST="Unknown"
		echo "* Kernel: ${OS}, version ${OSVER}"
		echo "* Distribution: ${DIST}"
		
		export PS1="${PROMPT_LINUX}"
		echo "* Set a usable prompt"
		
		echo "* Defining aliases:"
		alias ..="cd .."
		echo "   * .."
		alias ls="$(which ls) --color=auto --escape --file-type -h --time-style=long-iso"
		echo "   * ls"
		alias ll="$(which ls) --color=auto --escape -l --file-type -h --time-style=long-iso"
		echo "   * ll"
		alias df="$(which df) --human-readable --print-type"
		echo "   * df"
		alias d='date --rfc-3339=seconds | tr " " "T"'
		echo "   * d (ISO-style date)"
		;;
		
	"Darwin")
		# (Mac) OS X
		OS="Darwin"
		OSVER="$(uname -r)"
		DIST="OS X $(/usr/bin/python -c 'import platform; print platform.mac_ver()[0]')"
		echo "* Kernel: ${OS}, version ${OSVER}"
		echo "* Distribution: ${DIST}"
		
		export PS1="${PROMPT_OSX}"
		echo "* Set a usable prompt"
		
		echo "* Defining aliases:"
		alias ..="cd .."
		echo "   * .."
		alias ls="/bin/ls -G -F -b -h"
		echo "   * ls"
		alias ll="/bin/ls -l -G -F -b -h"
		echo "   * ll"
		alias df="/bin/df -h"
		echo "   * df"
		alias d='date "+%Y-%m-%dT%H:%M:%S%z"'
		echo "   * d (ISO-style date)"
		;;
		
	*)
		echo "Error: Neither GNU/Linux or Darwin/OS X detected. Only these systems are supported yet." >&2
		;;
esac

echo
echo "Done."
echo

