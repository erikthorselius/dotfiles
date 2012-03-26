alias cookiecurl='curl -b cookies.txt -c cookies.txt '
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc-4.2
export PATH="$PATH:~/Applications/maven/bin:/opt/app/instance/current/bin/"
source ~/.local/bin/bashmarks.sh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
