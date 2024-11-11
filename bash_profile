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
  source ~/.bashrc
fi

export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
PATH=$PATH:$HOME/go/bin
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.public-bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/opt/idea/bin
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:/opt/homebrew/bin
PATH=$PATH:/opt/homebrew/opt/coreutils/libexec/gnubin
export PATH
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dc='docker compose'

if [ -f ~/.dircolors ]; then
    eval $(gdircolors -b ~/.dircolors)
    unset LSCOLORS
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
