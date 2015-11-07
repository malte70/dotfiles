# 
# .zsh/prompt.zsh
#   ZSH prompt theme
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

get_git_prompt_info() {
	UPSTREAM=`gitinfo`
	if [[ $UPSTREAM != "no git" ]]; then
		echo -n "%F{cyan}[%B%F{white}${UPSTREAM}%b%F{cyan}] "
	fi
}

if [[ -z $ZSH_UI_MODE ]]; then
	export ZSH_UI_MODE="default"
fi

zsh-ui-mode() {
	if [[ $# -eq 0 ]]; then
		echo -e "Usage:"
		echo -e "\t$0\tdefault"
		echo -e "\t$0\tvms"
		echo -e "\t$0\tplain"
		echo -e "\t$0\tlinux"
	else
		_M="$(echo $1 | tr 'A-Z' 'a-z')"
		
		case $_M in
			default)
					export ZSH_UI_MODE="default"
					source ~/.zsh/prompt.zsh
					;;
			    vms)
					export ZSH_UI_MODE="vms"
					source ~/.zsh/prompt.zsh
					;;
			  plain)
					export ZSH_UI_MODE="plain"
					source ~/.zsh/prompt.zsh
					;;
			  linux)
					export ZSH_UI_MODE="linux"
					source ~/.zsh/prompt.zsh
					;;
			      *)
					echo -e "$0: Error: Unknown UI mode: $1"
					;;
		esac
	fi
}

if [[ $ZSH_UI_MODE == "default" ]]; then
	#
	# UI Mode: Default
	# 
	
	precmd() {
		print -Pn "\e]0;%~ (%n@%m)\a"
	}
	preexec() {
		CMD=`echo $1 | cut -d" " -f1`
		if [[ $CMD == "pycalc" ]]; then
			exit 0
		fi
		if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
			print -Pn "\e]0;%~ (%n@%m) ($CMD)\a"
		fi
	}
	setopt prompt_subst
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
	
	RPROMPT=""

elif [[ $ZSH_UI_MODE == "vms" ]]; then
	# 
	# UI Mode: VMS
	# 
	
	export VMS_HOST=`hostname -s | tr 'a-z' 'A-Z'`
	export VMS_USER=`id -un | tr 'a-z' 'A-Z'`
	preexec() {
		if pwd | grep $HOME &>/dev/null
		then
			export VMS_DEVICE='SYS$LOGIN'
		else
			export VMS_DEVICE='SYS$ROOT'
		fi
		export VMS_PATH=`pwd | sed "s@$HOME@@g" | sed 's@^/@@;s@/@.@g' | tr 'a-z' 'A-Z'`
		[[ -n $VMS_PATH ]] && export VMS_PATH="[${VMS_PATH}]"
		
		CMD=`echo $1 | cut -d" " -f1`
		P="${VMS_HOST}\"${VMS_USER}\"::${VMS_DEVICE}:${VMS_PATH}"
		if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
			print -Pn "\e]0;${P}\a"
		fi
	}
	preexec
	precmd() {
		preexec
		P="${VMS_HOST}\"${VMS_USER}\"::${VMS_DEVICE}:${VMS_PATH}"
		print "${P}"
		if [[ $TERM != "linux" ]]; then
			print -Pn "\e]0;${P}\a"
		fi
	}
	PROMPT="$ "
	RPROMPT=""
	REPORTTIME=-1

elif [[ $ZSH_UI_MODE == "plain" ]]; then
	# 
	# UI Mode: plain
	# 

	precmd() {
	}
	preexec() {
	}
	PROMPT="%% "
	RPROMPT=""
	REPORTTIME=-1

elif [[ $ZSH_UI_MODE == "linux" ]]; then
	# 
	# UI Mode: linux
	#
	
	precmd() {
		print -Pn "\e]0;%~ (%n@%m)\a"
	}
	preexec() {
		CMD=`echo $1 | cut -d" " -f1`
		if [[ $CMD == "pycalc" ]]; then
			exit 0
		fi
		if [[ ! $CMD =~ "[^ ]+=" && $TERM != "linux" ]]; then
			print -Pn "\e]0;%~ (%n@%m) ($CMD)\a"
		fi
	}
	
	PROMPT="%F{green}%n%F{white}@%B%m%b:%F{yellow}%B%~%F{white}%b%% "
	RPROMPT=""
	REPORTTIME=-1
fi

# for mc:
[[ ! -z "$MC_SID" ]] && { PROMPT="%n@%m$ "; RPROMPT="" }
true
