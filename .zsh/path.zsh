#
# .zsh/path.zsh
#   Sets $PATH 
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015-2016 Malte Bublitz, https://malte70.github.io
# All rights reserved.
# 

PATH=""
PATH=${PATH}${HOME}/bin:  # allow me to overwrite scripts installed by packages
[ -d "${HOME}/scripts" ] && PATH=${PATH}${HOME}/scripts: # on some hosts, ~/bin is not my github repository malte70/scripts, it is in ~/scripts.
[ -d "${HOME}/.local/bin" ] && PATH=${PATH}${HOME}/.local/bin:
PATH=${PATH}/usr/local/bin:
PATH=${PATH}/usr/local/sbin:
PATH=${PATH}/bin:
PATH=${PATH}/sbin:
PATH=${PATH}/usr/bin:
PATH=${PATH}/usr/sbin:
PATH=${PATH}/usr/bin/core_perl:
PATH=${PATH}/usr/bin/vendor_perl:
PATH=${PATH}/opt/java/jre/bin:
[ -d "/opt/android-sdk/platform-tools" ] && PATH=${PATH}/opt/android-sdk/platform-tools:
[ -d "/usr/games" ] && PATH=${PATH}/usr/games:
which ruby &>/dev/null && PATH=${PATH}$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:

if [[ "$(uname -o)" == "Msys" ]]
then
	PATH=""
	PATH="${PATH}${HOME}/bin:"
	PATH="${PATH}/mingw32/bin:"
	PATH="${PATH}/usr/bin:"
	PATH="${PATH}/bin:"
	PATH="${PATH}/c/Windows/system32:"
	PATH="${PATH}/c/Windows"
elif [[ -n "$ANDROID_DATA" ]]; then
	# Termux on Android
	TERMUX_ROOT="/data/data/com.termux/files"
	PATH=""
	PATH="${PATH}${TERMUX_ROOT}/usr/bin"
	PATH="${PATH}:${TERMUX_ROOT}/usr/bin/applets"
	PATH="${PATH}:${HOME}/bin"
	
	export TERMUX_ROOT
fi

export PATH
