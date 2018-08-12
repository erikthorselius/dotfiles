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
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
export PATH=$HOME/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
source ~/.oh-my-git/prompt.sh
if [[ $platform == 'linux' ]]; then
  LS_CMD=ls
  export LS_OPTIONS='--color=auto'
  eval $(dircolors ~/.dircolors)
elif [[ $platform == 'freebsd' ]]; then
  DIRCOLORS=dircolors
  LS_CMD=ls
  export LS_OPTIONS='-G'
elif [[ $platform == 'darwin' ]]; then
  LS_CMD=gls
  export LS_OPTIONS='--color=auto'
  eval $(gdircolors ~/.dircolors)
fi
