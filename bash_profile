platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='darwin'
fi

if [ -f ~/.public_bin/sensible.bash ]; then
  . ~/.public_bin/sensible.bash
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

function docker-test-filter() {
    docker exec -ti $1 sh -c "export PYTHONPATH=/app/lib/&&py.test --capture=no --junit-xml=.test-report.xml -vv tests -s -x -k $2"
}
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
export OS_USERNAME="erikt"
export TERMINAL=gnome-terminal
export GOROOT="/usr/local/go"
export GOPRIVATE="stash.trioptima.net"
export GOPATH=$HOME/go
export PATH=$PATH:~/.yarn/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/.public-bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/opt/idea/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/snap/bin
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias assh='ssh-agent ssh -F ~/.ssh/config.assh'
alias ascp='scp -F ~/.ssh/config.assh'
alias upload-keepass='rclone sync /home/erikt/Drive/Private drive:Privat'
alias download-keepass='rclone sync drive:Privat /home/erikt/Drive/Private'
alias ']'='xdg-open'
alias k=kubectl-1.14
complete -F __start_kubectl k
function kssh { ssh -A core@$(terraform output bastion_ip) "$*"; }
function kssh-vip { ssh -A core@$(terraform output ip) "$*"; }
