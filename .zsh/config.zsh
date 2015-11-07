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
DOMAIN="mcbx.de"
LOCAL_DOMAIN="tardis.$DOMAIN"
SERVERS=(
	"abyss.$DOMAIN"             # primary server
	"gimli.$DOMAIN"             # secondary server
	"web0.$DOMAIN"              # primary web server
	"minecraft.$DOMAIN"         # Minecraft server
	"demeter.$DOMAIN"           # Datux's server / primary mail server
	"khaos.$DOMAIN"             # test server / application server
	"deepthought.khaos.$DOMAIN" # Emulated System z on khaos
	"mcp.$LOCAL_DOMAIN"         # Local VM host server
)
DESKTOPS=(
	"sauron.$LOCAL_DOMAIN"      # main desktop
	"placenta.$LOCAL_DOMAIN"    # MacBook (OS X)
	"applepie.$LOCAL_DOMAIN"    # MacBook (Arch Linux)
)

# History: 10,000 lines in ~/.histfile
HISTFILE=~/.zsh/histfile
HISTSIZE=10000
SAVEHIST=10000

