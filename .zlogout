# 
# ~/.zlogout
# 

# FreeBSD: Clear screen on virtual consoles
if [[ $OS == "FreeBSD" && $TTY == /dev/ttyv* ]]; then
	clear
fi

