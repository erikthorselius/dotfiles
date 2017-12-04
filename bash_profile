platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi

export DOCKER_HOST=tcp://$(/usr/local/bin/boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
source ~/.local/bin/bashmarks.sh
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/JAVA_HOME"
export PATH=$HOME/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export PATH="~/Library/Python/2.7/bin:$PATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/erikthorselius/dev/accedo/via-mw/bin
export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=/Users/erikthorselius/dev/accedo/via-mw/image-resizer
if [ -f ~/.sensible.bash ]; then
   source ~/.sensible.bash
fi

source ~/.oh-my-git/prompt.sh
background=237
red='\e[0;31m'
omg_last_symbol_color="${red}\[\033[48;5;${background}m\]"
omg_ungit_prompt="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
omg_second_line="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1m\]\u\[\e[1;36m\]\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"

if [ $platform == 'darwin' ] && [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

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
alias ls='$LS_CMD $LS_OPTIONS -hF'
alias ll='$LS_CMD $LS_OPTIONS -lhF'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
eval "$(thefuck --alias)"
