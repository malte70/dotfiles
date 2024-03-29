# 
# ~/.zshenv
#     Always sourced by zsh, even for non-interactive
#     shells
# 
ZSHENV=1

# OS detection
source $HOME/.zsh/osdetect.zsh

# $PATH
source $HOME/.zsh/path.zsh

# ANSI Color codes
source $HOME/.zsh/ansi.zsh

# 
# Default applications (or their fallbacks if not installed)
# 
# - https://wiki.archlinux.org/title/Environment_variables#Default_programs
# - https://help.ubuntu.com/community/EnvironmentVariables
# 
# $EDITOR - Basic text editor
if which vim &>/dev/null; then
	EDITOR==vim
elif which nvim &>/dev/null; then
	EDITOR==nvim
elif which nano &>/dev/null; then
	EDITOR==nano
fi
export EDITOR

# $VISUAL - Full-fledged editor
if [[ $OS == "Mac OS X" ]]; then
	if [[ -z $SSH_CLIENT ]]; then
		if [[ -x "$HOME/.local/bin/CotEditor" ]]; then
			VISUAL="$HOME/.local/bin/CotEditor"
		else
			VISUAL="/usr/bin/open -t"
		fi
	fi
elif [ -n "$DISPLAY" ] && which xed &>/dev/null; then
	VISUAL==xed
elif [ -n "$DISPLAY" ] && which medit &>/dev/null; then
	VISUAL==medit
elif [ -n "$DISPLAY" ] && which pluma &>/dev/null; then
	VISUAL==pluma
else
	VISUAL=$EDITOR
fi
export VISUAL

# $PAGER - Scroll through output
if which most &>/dev/null; then
	PAGER==most
else
	PAGER==less
fi
export PAGER

# $BROWSER - Web browser
if which elinks &>/dev/null
then
	# If elinks is installed, set it as a fallback, just to be sure $BROWSER is
	# always set if no GUI browsers are available
	BROWSER==elinks
fi
if [[ -n $DISPLAY ]] && [[ $OS != "Mac OS X" ]]
then
	# X11 available (Either locally on a desktop or remote via VNC)
	# Check for a preferred browser (priority low → high)
	if which google-chrome-stable &>/dev/null
	then
		BROWSER==google-chrome-stable
	fi
	if which vivaldi-stable &>/dev/null
	then
		BROWSER==vivaldi-stable
	fi
	if which firefox &>/dev/null
	then
		BROWSER==firefox
	fi
	if which xdg-open &>/dev/null
	then
		BROWSER==xdg-open
	fi
elif [[ $OS == "Mac OS X" ]]; then
	# On OS X, open <URL> always launches the user's default browser of choice.
	BROWSER="/usr/bin/open"
fi
[ -n $BROWSER ] && export BROWSER

[ -f $HOME/.zshenv.local ] && . $HOME/.zshenv.local; true
