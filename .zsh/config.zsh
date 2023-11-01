# 
# .zsh/config.zsh
# 
# Configuration variables and setopt
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 



#
# my network setup. used to adjust behaviour to specific host
# 
DOMAIN="malte70.de"
ORG_DOMAIN="rolltreppe3.de"
LOCAL_DOMAIN="tardis.$DOMAIN"
HOSTS=(
	"torchwood.$LOCAL_DOMAIN"                # Notebook
	"pi.$LOCAL_DOMAIN"                       # Raspberry Pi 1
	"tau.$LOCAL_DOMAIN"                      # Raspberry Pi 4
	"mcp.$LOCAL_DOMAIN"                      # Mac mini
	"eddie.$LOCAL_DOMAIN"                    # HP Workstation
	"gibson.$LOCAL_DOMAIN"                   # Workstation 1
	"deepthought.$ORG_DOMAIN"                # Root server
	"web.deepthought.$ORG_DOMAIN"            # Web server
	"workstation.deepthought.$ORG_DOMAIN"    # Cloud workstation
	"minecraft.deepthought.$ORG_DOMAIN"      # Minecraft server
	"sauron.$LOCAL_DOMAIN"                   # Small Desktop
)
ACCOUNTS=(
	"malte70@torchwood.$LOCAL_DOMAIN"
	"pi@raspberrypi.$LOCAL_DOMAIN"
	"pi@tau.$LOCAL_DOMAIN"
	"malte70@mcp.$LOCAL_DOMAIN"
	"malte70@deepthought.$ORG_DOMAIN"
	"merkvr@deepthought.$ORG_DOMAIN"
	"malte70@web.deepthought.$ORG_DOMAIN"
	"merkvr@web.deepthought.$ORG_DOMAIN"
	"malte70@workstation.deepthought.$ORG_DOMAIN"
	"malte70@minecraft.deepthought.$ORG_DOMAIN"
	"merkvr@minecraft.deepthought.$ORG_DOMAIN"
)
unset DOMAIN ORG_DOMAIN



# 
# Optional features in my zsh configuration
# 
SHOW_NOTES="no"



# 
# History: 100,000 lines in ~/.zsh/histfile
# 
HISTFILE=~/.zsh/histfile
HISTSIZE=100000
SAVEHIST=100000



# 
# zsh Options
# 
# Always push $OLDPWD
setopt AUTO_CD

# Don't overwrite existing files when redirecting output
setopt NO_CLOBBER

# No silent chdir $TERM
setopt CD_SILENT
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# history
#setopt APPEND_HISTORY
#setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

# never ever beep ever
unsetopt BEEP NOTIFY

# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD



# Load modules
zmodload zsh/attr 2>/dev/null
zmodload zsh/termcap
zmodload zsh/terminfo


# Access On-Line help
# Fails because run-help is an alias for man
unalias run-help 2>/dev/null
autoload run-help
alias help=run-help
alias get-help=run-help


