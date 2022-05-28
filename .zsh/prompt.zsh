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

prompt_get_git_info() {
	UPSTREAM=`env gitinfo`
	if [[ $UPSTREAM != "no git" ]]; then
		echo -n "%F{cyan}[%B%F{white}${UPSTREAM}%b%F{cyan}] "
	fi
}
prompt_get_host_icon() {
	# Get an Nerd Font icon for the Host
	if [[ $HOST == "deepthought.rolltreppe3.de" ]]; then
		printf "\uf233 "
		
	elif [[ $HOST == "web.deepthought.rolltreppe3.de" ]]; then
		printf "\ufa9e "
		
	elif [[ $HOST == "minecraft.deepthought.rolltreppe3.de" ]]; then
		printf "\uf872 "
		
	elif [[ $HOST == "workstation.deepthought.rolltreppe3.de" ]]; then
		printf "\uf233  "

	elif [[ $OS == "Mac OS X" ]]; then
		printf "\ue711 "
		
	elif [[ $OSVARIANT == "Ubuntu" ]]; then
		printf "\uf31b "
		
	elif [[ $OSVARIANT == "Raspbian" ]]; then
		printf "\uf315 "
		
	elif [[ $OSVARIANT == "Arch" ]]; then
		printf "\uf303 "
		
	elif [[ $OS == "GNU/Linux" ]]; then
		printf "\ue712 "
		
	elif [[ $OS == "FreeBSD" ]]; then
		printf "\uf30c "
		
	fi
}
setopt prompt_subst

# Those mixed-case hostnames on Windows suck...
HOSTNAME_LOWER=$(hostname | tr 'A-Z' 'a-z')

# User color - Red for root, green for other users
if [[ $UID -eq 0 ]]; then
	PROMPT_USER_COLOR="%F{red}"
else
	PROMPT_USER_COLOR="%F{green}"
fi

PROMPT="%F{cyan}[%F{green}%B`uname -m`%b%F{cyan}|%F{green}%B$OS%b%F{cyan}|%F{green}%B$OSVERSION%b%F{cyan}]%(?.. %F{cyan}[%F{red}%?%F{cyan}]) "'$(prompt_get_git_info)%F{white}$(prompt_get_host_icon)'"%F{yellow}%~%b%F{white}
%F{white}%n@${PROMPT_USER_COLOR}%m%F{white}$ "

# Those mixed-case hostnames on Windows suck...
if [[ "$OS" == "Windows NT" ]]
then
	PROMPT=$(echo $PROMPT | sed "s/%m/$HOSTNAME_LOWER/g")
elif [[ "$OS" == "Android" ]]
then
	PROMPT=$(echo $PROMPT | sed "s/%n@//g;s/%m/$HOSTNAME_ANDROID/g")
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
