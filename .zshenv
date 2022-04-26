# 
# ~/.zshenv
#     Always sourced by zsh, even for non-interactive
#     shells
# 
ZSHENV=1

# $PATH
source $HOME/.zsh/path.zsh

# OS detection
source $HOME/.zsh/osdetect.zsh

# ANSI Color codes
source $HOME/.zsh/ansi.zsh

# Default applications
EDITOR==vim
if which most &>/dev/null; then
	PAGER==most
else
	PAGER==less
fi
if which elinks &>/dev/null
then
	# If elinks is installed, set it as a fallback, just to be sure $BROWSER is
	# always set if no GUI browsers are available
	BROWSER==elinks
fi
if [[ -n $DISPLAY ]] && [[ $OS != "Mac OS X" ]]
then
	# X11 available (Either locally on a desktop or remote via VNC)
	if which firefox &>/dev/null
	then
		BROWSER==firefox
	fi
	if which xdg-open &>/dev/null
	then
		BROWSER==xdg-open
	fi
	if which vivaldi-stable &>/dev/null
	then
		BROWSER==vivaldi-stable
	fi
elif [[ $OS == "Mac OS X" ]]; then
	# On OS X, open <URL> always launches the user's default browser of choice.
	BROWSER=open
elif [[ $OS == "Android" ]]; then
	# Termux provides termux-open-url in termux-tools
	if ! which termux-open-url &>/dev/null; then
		BROWSER=termux-open-url
	fi
fi

[ -f $HOME/.zshenv.local ] && . $HOME/.zshenv.local; true
