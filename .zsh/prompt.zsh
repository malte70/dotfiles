# 
# .zsh/prompt.zsh
#   ZSH prompt theme
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015-2016 Malte Bublitz, https://malte70.github.io
# All rights reserved.
# 
# Example:
# 
# [x86_64|GNU/Linux|4.2.5-1-ARCH] [1] [malte70/geheim:master:5] ~/code/geheim
# malte70@sauron$ _
# 
# [1] => Return value of last command if non-equal
# [malte70/geheim:master:5]  => Git repository on branch master, 5 uncommited
#                               changes, and origin is malte70/geheim on Github
# 

get_git_prompt_info() {
	UPSTREAM=`gitinfo`
	if [[ $UPSTREAM != "no git" ]]; then
		echo -n "%F{cyan}[%B%F{white}${UPSTREAM}%b%F{cyan}] "
	fi
}
setopt prompt_subst

# Those mixed-case hostnames on Windows suck...
HOSTNAME_LOWER=$(hostname | tr 'A-Z' 'a-z')

precmd() {
	if [[ "$OS" != "Windows NT" ]]
	then
		print -Pn "\e]0;%~ (%n@%m)\a"
	else
		print -Pn "\e]0;%~ (%n@${HOSTNAME_LOWER})\a"
	fi
}
preexec() {
	CMD=`echo $1 | cut -d" " -f1`
	if [[ CMD == "pycalc" ]]; then
		exit 0
	fi
	if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
		# Those mixed-case hostnames on Windows suck...
		if [[ "$OS" != "Windows NT" ]]
		then
			print -Pn "\e]0;%~ (%n@%m) ($CMD)\a"
		else
			print -Pn "\e]0;%~ (%n@${HOSTNAME_LOWER}) ($CMD)\a"
		fi
	fi
}

# User color - Red for root, green for other users
if [[ $UID -eq 0 ]]; then
	PROMPT_USER_COLOR="%F{red}"
else
	PROMPT_USER_COLOR="%F{green}"
fi

PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B$OS%b%F{cyan}|%F{green}%B$OSVERSION%b%F{cyan}]%(?.. %F{cyan}[%F{red}%?%F{cyan}]) "'$(get_git_prompt_info)'"%F{yellow}%~%b%F{white}
%F{white}%n@${PROMPT_USER_COLOR}%m%F{white}$ "

# Those mixed-case hostnames on Windows suck...
if [[ "$OS" == "Windows NT" ]]
then
	PROMPT=$(echo $PROMPT | sed "s/%m/$HOSTNAME_LOWER/g")
fi

# 
# Display runtime of commands that run longer than 5 seconds (no need for time $command anymore)
# 
# Value is the minimum time for displaying the runtime. -1 disables this feature.
# 
REPORTTIME=-1

# for mc:
if [[ ! -z "$MC_SID" ]]; then
	PROMPT="%n@%m$ "
	RPROMPT=""
fi
