platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
fi
alias cookiecurl='curl -b cookies.txt -c cookies.txt '
#alias less='vim -u /usr/share/vim/vim73/macros/less.vim'
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc-4.2
export PATH=$HOME/bin:$PATH
source ~/.local/bin/bashmarks.sh
export ANDROID_SDK_ROOT=/usr/local/Cellar/android-sdk/active
export ANDROID_HOME="/usr/local/Cellar/android-sdk/active"
export NODE_PATH="/usr/local/lib/node_modules"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home"
export DOCKER_HOST=tcp://$(/usr/local/bin/boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export HISTSIZE=20000
export RBENV_ROOT=/usr/local/var/rbenv
export PATH="/usr/local/var/rbenv/versions/2.2.0/bin:$PATH"
export PATH="/opt/chefdk/bin:$PATH"
export PATH="/Applications/Zed.app/bin":$PATH
shopt -s histappend

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Intranätet
export WORKON_HOME=$HOME/.virtualenvs
###

# A two-line colored Bash prompt (PS1) with Git branch and a line decoration
# which adjusts automatically to the width of the terminal.
# Screenshot: http://img194.imageshack.us/img194/2154/twolineprompt.png
# Michal Kottman, 2012
 
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
PS_LINE=`printf -- '- %.0s' {1..200}`
function parse_git_branch {
  PS_GIT_BRANCH=''
  PS_FILL=${PS_LINE:0:$COLUMNS}
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_GIT_BRANCH="(${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_GIT_BRANCH"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"
export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "

if [ $platform == 'darwin' ] && [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

if [[ $platform == 'linux' ]]; then
  DIRCOLORS=dircolors
  LS_CMD=ls
elif [[ $platform == 'darwin' ]]; then
  DIRCOLORS=gdircolors
  LS_CMD=gls
fi
if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  eval $($DIRCOLORS ~/.dircolors)
fi
alias ls='$LS_CMD $LS_OPTIONS -hF'
alias ll='$LS_CMD $LS_OPTIONS -lhF'
alias l='$LS_CMD $LS_OPTIONS -lAhF'

