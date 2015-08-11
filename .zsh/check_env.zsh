# 
# .zsh/check_env.zsh
#   Check the environment for possible incompatibility issues
# 

if ! which gitinfo &>/dev/null; then
	cat <<EOF >&2
gitinfo was not found in \$PATH!"

Please clone the repository https://github.com/malte70/scripts to ~/bin:"

  git clone https://github.com/malte70/scripts ~/bin"

EOF
fi

if ! which vim &>/dev/null; then
	echo "vim was not found!" >&2
fi

if ! which python &>/dev/null; then
	echo "python was not found!" >&2
fi
