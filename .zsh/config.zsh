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
LOCAL_DOMAIN="tardis.$DOMAIN"
HOSTS=(
	"torchwood.$LOCAL_DOMAIN"    # Notebook
	"raspberrypi.$LOCAL_DOMAIN"  # Raspberry Pi
	"nas.$LOCAL_DOMAIN"          # NAS
	"sauron.$LOCAL_DOMAIN"       # Desktop
	"spandau.rolltreppe3.de"     # VPS
)
ACCOUNTS=(
	"malte70@torchwood.$LOCAL_DOMAIN"
	"pi@raspberrypi.$LOCAL_DOMAIN"
	"malte70@nas.$LOCAL_DOMAIN"
	"malte70@sauron.$LOCAL_DOMAIN"
	"malte70@spandau.rolltreppe3.de"
	"root@nas.$LOCAL_DOMAIN"
)

# History: 10,000 lines in ~/.histfile
HISTFILE=~/.zsh/histfile
HISTSIZE=10000
SAVEHIST=10000

