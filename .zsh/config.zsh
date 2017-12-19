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
DOMAIN="ancistrus.de"
LOCAL_DOMAIN="tardis.$DOMAIN"
HOSTS=(
	"mcp.$LOCAL_DOMAIN"         # Main workstation
	"pluto.$LOCAL_DOMAIN"       # Netbook
	"nas.$LOCAL_DOMAIN"         # NAS
	"moto-g.$LOCAL_DOMAIN"      # Smartphone (for FTP via FileManager HD)
	"backfisch.falken.$DOMAIN"  # Pascal's notebook
)
ACCOUNTS=(
	"malte70@mcp.$LOCAL_DOMAIN"
	"malte70@pluto.$LOCAL_DOMAIN"
	"malte70@nas.$LOCAL_DOMAIN"
	"malte70@moto-g.$LOCAL_DOMAIN"
	"malte70@backfisch.falken.$DOMAIN"
	"root@nas.$LOCAL_DOMAIN"
	"pascal@pluto.$LOCAL_DOMAIN"
	"pascal@backfisch.falken.$DOMAIN"
)

# History: 10,000 lines in ~/.histfile
HISTFILE=~/.zsh/histfile
HISTSIZE=10000
SAVEHIST=10000

