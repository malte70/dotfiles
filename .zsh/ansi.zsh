# 
# .zsh/ansi.zsh
#     ANSI escape codes
# 

# 
# The ESC character (U+001B)
# 
_ANSI_ESCAPE=$(printf "\e")

# 
# Reset all formatting
# 
_ANSI_RESET="${_ANSI_ESCAPE}[0m"

# 
# (Classic) Attributes and their reset codes
# 
_ANSI_ATTR_BOLD="${_ANSI_ESCAPE}[1m"
_ANSI_ATTR_BOLD_RESET="${_ANSI_ESCAPE}[21m"
_ANSI_ATTR_ITALIC="${_ANSI_ESCAPE}[3m"
_ANSI_ATTR_ITALIC_RESET="${_ANSI_ESCAPE}[23m"
_ANSI_ATTR_UNDERLINE="${_ANSI_ESCAPE}[4m"
_ANSI_ATTR_UNDERLINE_RESET="${_ANSI_ESCAPE}[24m"
_ANSI_ATTR_STRIKETHROUGH="${_ANSI_ESCAPE}[9m"
_ANSI_ATTR_STRIKETHROUGH_RESET="${_ANSI_ESCAPE}[29m"
# Switch foreground<->Background colors
_ANSI_ATTR_INVERSE="${_ANSI_ESCAPE}[7m"
_ANSI_ATTR_INVERSE_RESET="${_ANSI_ESCAPE}[27m"
# Annoying, but included for the sake of completeness
_ANSI_ATTR_BLINKING="${_ANSI_ESCAPE}[5m"
_ANSI_ATTR_BLINKING_RESET="${_ANSI_ESCAPE}[25m"
# Like _ANSI_ATTR_BLINKING; I don't even know any practical use for this…
_ANSI_ATTR_HIDDEN="${_ANSI_ESCAPE}[8m"
_ANSI_ATTR_HIDDEN_RESET="${_ANSI_ESCAPE}[28m"

# 
# Advanced "attributes"/functionality
# WARNING: No detection if the terminal supports these!
# 
# - ESC[?25h    make cursor visible
# - ESC[?25l    make cursor invisible
# - ESC[?47h    save screen
# - ESC[?47l    restore screen
# - ESC[?1049h  enables the alternative buffer
# - ESC[?1049l  disables the alternative buffer
# 
_ANSI_ATTR_CURSOR_VISIBLE="${_ANSI_ESCAPE}[?25h"
_ANSI_ATTR_CURSOR_HIDDEN="${_ANSI_ESCAPE}[?25l"
_ANSI_ATTR_SCREEN_SAVE="${_ANSI_ESCAPE}[?47h"
_ANSI_ATTR_SCREEN_RESTORE="${_ANSI_ESCAPE}[?47l"
_ANSI_ATTR_ALTERNATE_BUFFER_ENABLED="${_ANSI_ESCAPE}[?1049h"
_ANSI_ATTR_ALTERNATE_BUFFER_DISABLED="${_ANSI_ESCAPE}[?1049l"

# 
# Colors (original 16 colors)
# 
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



