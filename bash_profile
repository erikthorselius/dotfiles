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

if [ -x ~/.dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.public-bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/opt/idea/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="/opt/homebrew/bin/brew:$PATH"
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dc='docker compose'
