#!/usr/bin/env bash
#
# foobar.sh
#    Part of: Project X
# 
# Does epic things.
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

SCRIPT_NAME="foobar.sh"
SCRIPT_VERSION="0.20150802"

_ANSI_ESCAPE=$(printf "\e")
_ANSI_RESET="${_ANSI_ESCAPE}[0m"
_ANSI_ATTR_BOLD="${_ANSI_ESCAPE}[1m"
_ANSI_ATTR_UNDERLINE="${_ANSI_ESCAPE}4m"
_ANSI_COLOR_BLACK="${_ANSI_ESCAPE}[0;30m"
_ANSI_COLOR_RED="${_ANSI_ESCAPE}[0;31m"
_ANSI_COLOR_GREEN="${_ANSI_ESCAPE}[0;32m"
_ANSI_COLOR_YELLOW="${_ANSI_ESCAPE}[0;33m"
_ANSI_COLOR_BLUE="${_ANSI_ESCAPE}[0;34m"
_ANSI_COLOR_DARK_MAGENTA="${_ANSI_ESCAPE}[0;35m"
_ANSI_COLOR_DARK_CYAN="${_ANSI_ESCAPE}[0;36m"
_ANSI_COLOR_GREY="${_ANSI_ESCAPE}[0;37m"
_ANSI_COLOR_DARK_GREY="${_ANSI_ESCAPE}[1;30m"
_ANSI_COLOR_LIGHT_RED="${_ANSI_ESCAPE}[1;31m"
_ANSI_COLOR_LIGHT_GREEN="${_ANSI_ESCAPE}[1;32m"
_ANSI_COLOR_LIGHT_YELLOW="${_ANSI_ESCAPE}[1;33m"
_ANSI_COLOR_LIGHT_BLUE="${_ANSI_ESCAPE}[1;34m"
_ANSI_COLOR_MAGENTA="${_ANSI_ESCAPE}[1;35m"
_ANSI_COLOR_CYAN="${_ANSI_ESCAPE}[1;36m"
_ANSI_COLOR_WHITE="${_ANSI_ESCAPE}[1;37m"

_print() {
	printf $@
}
_println() {
	printf $@
	echo
}
_print_term() {
	if [[ $TERM != "dump" ]]; then
		_print $@
	fi
}
_println_term() {
	if [[ $TERM != "dump" ]]; then
		_println $@
	fi
}

message() {
	_print_term $_ANSI_COLOR_GREEN
	_print "[${SCRIPT_NAME}] "
	_print_term $_ANSI_RESET
	_println $@
}
message_error() {
	(
		_print_term $_ANSI_COLOR_RED
		_print "[${SCRIPT_NAME}] Error:"
		_print_term $_ANSI_RESET
		_println $@
	) >&2
}

version() {
	echo "$SCRIPT_NAME $SCRIPT_VERSION"
}
usage() {
	echo "Usage:"
	echo "	$SCRIPT_NAME"
	echo "	$SCRIPT_NAME [--switch]"
	echo
	echo "Options:"
	echo "	--version -V  Show the version and exit"
	echo "	--help -h     Show the help and exit"
	echo "	--switch  An epic switch"
	echo
}

if [[ "$1" == "--version" || "$1" == "-V" ]]; then
	version
	exit 0
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
	version
	usage
	exit 0
fi

# do some stuff
_print_term $_ANSI_COLOR_GREEN
echo "Doing epic shit..."
_print_term $_ANSI_RESET

