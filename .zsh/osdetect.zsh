# 
# .zsh/osdetect.zsh
#   OS detection
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015-2016 Malte Bublitz, https://malte70.github.io
# All rights reserved.
# 

OS=`uname -s`
OSVERSION=`uname -r`
if [[ "$OS" == "Darwin" ]]; then
	OS="Mac OS X"
	OSVARIANT=$OS
	OSXVersion=`python -c 'import platform; print platform.mac_ver()[0],'`
	OSVERSION=$OSXVersion
elif [[ `uname -o` == "Cygwin" ]]; then
	OS="Windows NT"
	OSVERSION=`python -c 'import OSDetect; _i = OSDetect.OSInfo(); print _i.GetInfo()["OSVersion"]'`
elif [[ `uname -o` == "Msys" ]]; then
	OS="Windows NT"
	#OSVERSION=`python -c 'import OSDetect; print(OSDetect.info["OS"].split("-")[1])'`
	OSVERSION=`uname -s | cut -d- -f2`
elif which zsh | grep "com.termux" &> /dev/null; then
	# Termux on Android
	OS="Android"
	OSVARIANT="Termux"
	OSVERSION=$(getprop ro.build.version.release)
	HOSTNAME_ANDROID=$(getprop net.hostname)
	if [[ -z "$HOSTNAME_ANDROID" ]]
	then
		# No hostname set - fall back to devicename
		HOSTNAME_ANDROID=$(getprop ro.product.device)
	fi
else
	OS=`uname -o`
	if which lsb_release &>/dev/null; then
		OSVARIANT=`lsb_release -s -i`
	else
		OSVARIANT=$OS
	fi
	OSVERSION=`uname -r`
fi

