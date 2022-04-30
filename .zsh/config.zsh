# 
# .zsh/config.zsh
#   Configuration variables
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

# my network setup. used to adjust behaviour to specific host
DOMAIN="malte70.de"
ORG_DOMAIN="rolltreppe3.de"
LOCAL_DOMAIN="tardis.$DOMAIN"
HOSTS=(
	"torchwood.$LOCAL_DOMAIN"                # Notebook
	"raspberrypi.$LOCAL_DOMAIN"              # Raspberry Pi 1
	"tau.$LOCAL_DOMAIN"                      # Raspberry Pi 4
	"mcp.$LOCAL_DOMAIN"                      # Mac mini
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

# History: 100,000 lines in ~/.histfile
HISTFILE=~/.zsh/histfile
HISTSIZE=100000
SAVEHIST=100000

