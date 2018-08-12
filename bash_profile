platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='darwin'
fi
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
if [ -f ~/.public_bin/sensible.bash ]; then
  . ~/.public_bin/sensible.bash
fi
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
export PATH=$HOME/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/idea/bin:$PATH"
source ~/.oh-my-git/prompt.sh
