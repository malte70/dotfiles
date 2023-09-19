# 
# .zsh/todo.zsh
#     Show todo if logging in
# 
# Part of:
#     malte70's dotfiles, https://github.com/malte70/dotfiles
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

if [[ $TERM_PROGRAM == "vscode" ]]; then
	# Hide todo and notes in Visual Studio Code's terminal
	SHOW_TODO="no"
	DID_SHOW_NOTES="yes"
fi


if which todo &>/dev/null && [[ -f "$HOME/.todo" ]]; then
	[ -z $SHOW_TODO ] && SHOW_TODO="yes"
	
	if [[ $SHOW_TODO != "no" && "$(eval ${TODO} | wc -l)" -ne 2 ]]; then
		todo
		echo
	fi
	SHOW_TODO="no"
fi

# Show notes
NOTES="$HOME/.notes"
show_notes() {
	if [[ ! -f "$NOTES" ]]
	then
		echo "Notefile ~/.notes not found." >&2
		exit 1
	else
		cat "$NOTES"
	fi
}
if [[ -x =${EDITOR} ]]
then
	edit_notes() {
		$EDITOR "$NOTES"
	}
fi

# Show notes when shell starts (but not if .zshrc is sourced again!)
if [[ "$SHOW_NOTES" == "yes" && "$DID_SHOW_NOTES" != "yes" && -f "$NOTES" ]]
then
	# Only show if 10 lines or less to not mess up the screen
	if [[ $(wc -l "$NOTES" | cut -d" " -f1) -lt 12 ]]
	then
		show_notes
		DID_SHOW_NOTES=yes
	else
		cat <<EOF

Notefile to long to display automatically.
To show it at any time, use \`show_notes\`

EOF
	fi
fi

