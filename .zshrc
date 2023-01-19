#
# .zshrc
#
# Part of malte70's dotfiles
#  https://github.com/malte70/dotfiles
#
# Copyright (c) 2012-2016 Malte Bublitz, https://malte70.github.io
# All rights reserved.
# 

# At this point, ~/.zshenv should already executed, but I had problems
# with some special situations where it was not.
source $HOME/.zshenv

# Check the environment for possible incompatibilities
# Needs $PATH correctly set up before.
source $HOME/.zsh/check_env.zsh

# Configuration
source $HOME/.zsh/config.zsh

if which dircolors &>/dev/null; then
	# On OS X, there is no dircolors, but it is not needed
	eval `dircolors -b`
fi
setopt autocd
setopt noclobber
unsetopt beep notify

# vi keybindings
bindkey -v
# basic key bindings (portable, based on zsh article in the Official Arch Wiki)
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# allow backward history search including regexp using ^R (like known from GNU bash)
bindkey "^R" history-incremental-pattern-search-backward

# completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' menu select=0
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' rehash true

my_accounts=($HOSTS $ACCOUNTS)

zstyle ':completion:*:my-accounts' users-hosts $my_accounts
# Zsh completions from zsh-completions Homebrew formula
# @see https://stackoverflow.com/a/22753363
if type brew &>/dev/null; then
	if [[ -d "$(brew --prefix)/share/zsh-completions" ]]; then
		FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
	fi
fi

autoload -Uz compinit
compinit
autoload -U _requested _normal _setup _tags _next_label _path_files _parameters _wanted _set_command _suffix_alias_files
autoload -U _vim
autoload -U _sudo
autoload -U _ssh
autoload -U _source
autoload -U _tar
autoload -U _tar_archive
autoload -U _typeset
autoload -Uz ztodo

# define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

# just type 'cd ...' to get 'cd ../..'
rationalise-dot() {
  if [[ $LBUFFER == *.. ]] ; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# Allow comments even in interactive shells
setopt interactivecomments

# Exit on ^D even if current command line isn't empty
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# default browser and editor
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
	if which xdg-open &>/dev/null
	then
		BROWSER==xdg-open
	fi
	if which firefox &>/dev/null
	then
		BROWSER==firefox
	fi
	if which google-chrome-stable &>/dev/null
	then
		BROWSER==google-chrome-stable
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
	BROWSER=termux-open-url
	if ! which $BROWSER &>/dev/null; then
		BROWSER=
		echo "Warning: Please install termux-tools and reload zshrc:" >&2
		echo "  apt install termux-tools && zshrc-reload" >&2
	fi
else
	if ! which elinks &>/dev/null; then
		echo "WARNING: ELinks not found in PATH!" >&2
	fi
fi
if [ -d $HOME/Mail ]; then
	export MAIL=~/Mail
fi
export EDITOR PAGER BROWSER

source $HOME/.zsh/alias.zsh

# map STOP to ^A (START is ^Q, and also, ^S is free to be used by vim)
stty stop ^A

source $HOME/.zsh/prompt.zsh

source $HOME/.zsh/todo.zsh

# Define $PYTHONSTARTUP. See python(1) for details
PYTHONSTARTUP="$HOME/.pythonstartup"
if [[ -f "$PYTHONSTARTUP" ]]; then
	export PYTHONSTARTUP
else
	unset PYTHONSTARTUP
fi

# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key
GPG_TTY=$(tty)
export GPG_TTY

# https://github.com/zsh-users/zsh-syntax-highlighting
[[ -d "/usr/share/zsh/plugins/zsh-syntax-highlighting" ]] && \
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -d "/usr/share/zsh-syntax-highlighting" ]] && \
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -d "/opt/homebrew/share/zsh-syntax-highlighting" ]] && \
	source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -d "/usr/local/share/zsh/plugins/zsh-syntax-highlighting" ]] && \
	source /usr/local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# git-extras
[[ -f /usr/share/doc/git-extras/git-extras-completion.zsh ]] && \
	source /usr/share/doc/git-extras/git-extras-completion.zsh
[[ -d /opt/homebrew/share/git-extras ]] && \
	source /opt/homebrew/share/git-extras/git-extras-completion.zsh
autoload -U _git-extras

# 
# Default options for less(1)
# 
# --RAW-CONTROL-CHARS: Allow ANSI "color" escape codes
# --tilde:             Show lines after EOF as empty lines instead of a "~"
# -Ps<less>:           Set a custom prompt
# 
export LESS="--RAW-CONTROL-CHARS --tilde -Ps<less>"

[ -f $HOME/.zshrc.local ] && . $HOME/.zshrc.local; true

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

