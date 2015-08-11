#
# .zsh/path.zsh
#   Sets $PATH 
#

PATH=""
PATH=${PATH}${HOME}/bin:  # allow me to overwrite scripts installed by packages
[ -d "${HOME}/scripts" ] && PATH=${PATH}${HOME}/scripts: # on some hosts, ~/bin is not my github repository malte70/scripts, it is in ~/scripts.
#[ $OS = "Mac OS X" ] && PATH=${PATH}/usr/local/opt/php55/bin:
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
which ruby &>/dev/null && PATH=${PATH}$(ruby -rubygems -e 'puts Gem.user_dir')/bin:
export PATH
