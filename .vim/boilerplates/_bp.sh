#!/usr/bin/env zsh
#

SCRIPT_NAME="foobar.sh"
SCRIPT_VERSION="0.20150802"

version() {
	echo "$SCRIPT_NAME $SCRIPT_VERSION"
}
usage() {
	echo "Usage:"
	echo "	$SCRIPT_NAME"
	echo "	$SCRIPT_NAME [--switch]"
	echo
	echo "Options:"
	echo "	--switch  An epic switch"
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
