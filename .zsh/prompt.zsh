#!/bin/zsh
# prompt theme
get_git_prompt_info() {
	UPSTREAM=`gitinfo`
	if [[ $UPSTREAM != "no git" ]]; then
		echo -n "%F{cyan}[%B%F{white}${UPSTREAM}%b%F{cyan}] "
	fi
}
setopt prompt_subst
precmd() {
	print -Pn "\e]0;%~ (%n@%m)\a"
}
preexec() {
	CMD=`echo $1 | cut -d" " -f1`
	if [[ CMD == "pycalc" ]]; then
		exit 0
	fi
	if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
		print -Pn "\e]0;%~ (%n@%m) ($CMD)\a"
	fi
}
if [[ $OS == "Mac OS X" ]]; then
	PROMPT="]0;$HOST: $PWD" # ^G = BEL
else
	PROMPT=""
fi
PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B$OS%b%F{cyan}|%F{green}%B$OSVERSION%b%F{cyan}]%(?.. %F{cyan}[%F{red}%?%F{cyan}]) "'$(get_git_prompt_info)'"%F{yellow}%~%b%F{white}
%F{white}%n@"
if [[ $UID -ne 0 ]]; then
	PROMPT="$PROMPT%F{green}"
else
	PROMPT="$PROMPT%F{red}"
fi
PROMPT="$PROMPT%m%F{white}$ "

# Display runtime of commands that run longer than 5 seconds (no need for time $command anymore)
REPORTTIME=5

# for mc:
[[ ! -z "$MC_SID" ]] && { PROMPT="%n@%m$ "; RPROMPT="" }
true
