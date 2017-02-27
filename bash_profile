platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi
alias cookiecurl='curl -b cookies.txt -c cookies.txt '
#alias less='vim -u /usr/share/vim/vim73/macros/less.vim'
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc
export PATH=$HOME/bin:$PATH
source ~/.local/bin/bashmarks.sh
#export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/active
#export ANDROID_HOME="/usr/local/Cellar/android-sdk/active"
export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk
export ANDROID_HOME=/usr/local/opt/android-sdk
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/JAVA_HOME"
export DOCKER_HOST=tcp://$(/usr/local/bin/boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export HISTSIZE=20000
export RBENV_ROOT=/usr/local/var/rbenv
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH="/usr/local/var/rbenv/versions/2.2.0/bin:$PATH"
export PATH="/Applications/Zed.app/bin":$PATH
shopt -s histappend

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

if [ -f ~/.sensible.bash ]; then
   source ~/.sensible.bash
fi

source ~/.oh-my-git/prompt.sh
background=237
red='\e[0;31m'
omg_last_symbol_color="${red}\[\033[48;5;${background}m\]"

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
  PATH=$PATH:/Applications/LightTable
fi
alias ls='$LS_CMD $LS_OPTIONS -hF'
alias ll='$LS_CMD $LS_OPTIONS -lhF'
alias l='$LS_CMD $LS_OPTIONS -lAhF'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
