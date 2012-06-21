alias cookiecurl='curl -b cookies.txt -c cookies.txt '
#alias less='vim -u /usr/share/vim/vim73/macros/less.vim'
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
#export PATH="$PATH:$HOME/android-sdk-mac_x86/tools:$HOME/android-sdk-mac_x86/platform-tools"
export CC=gcc-4.2
export PATH="$PATH:~/Applications/maven/bin:/opt/app/instance/current/bin"
source ~/.local/bin/bashmarks.sh
export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/r18
export ANDROID_HOME="/usr/local/Cellar/android-sdk/r18"
export NODE_PATH="/usr/local/lib/node_modules"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
