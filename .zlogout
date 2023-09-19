# 
# ~/.zlogout
# 

# Linux & FreeBSD: Clear screen on virtual consoles
if [[ $OS == "GNU/Linux" && $TTY == /dev/tty* ]] || [[ $OS == "FreeBSD" && $TTY == /dev/ttyv* ]]; then
	clear
fi

