# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Path to your oh-my-bash installation.
export OSH=/home/erikt/.oh-my-bash

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerline-multiline"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(core rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git bashmarks progress bu golang kubectl)

# User configuration
source $OSH/oh-my-bash.sh
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias assh='ssh-agent ssh -F ~/.ssh/config.assh'
alias ascp='scp -F ~/.ssh/config.assh'
alias upload-keepass='rclone sync -P /home/erikt/Drive/Private drive:Privat'
alias download-keepass='rclone sync -P drive:Privat /home/erikt/Drive/Private'
alias upload-beersmith='rclone sync -P /home/erikt/Drive/beersmith3 drive:beersmith3'
alias download-beersmith='rclone sync -P drive:beersmith3 /home/erikt/Drive/beersmith3'
alias beersmith='sudo docker run -ti --rm --init -e DISPLAY=$DISPLAY -u $UID:$(id -g $USER) -v /tmp/.X11-unix:/tmp/.X11-unix -v /dev/snd:/dev/snd:rw -v /home/erikt:/home/beersmith3 bcrochet/beersmith3'

if [ -x ~/.dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ']'='xdg-open'
function docker-test-filter() {
    docker exec -ti $1 sh -c "export PYTHONPATH=/app/lib/&&py.test --capture=no --junit-xml=.test-report.xml -vv tests -s -x -k $2"
}
export PATH=$PATH:~/.yarn/bin
export PATH=$PATH:~/bin
export PATH=$PATH:/usr/lib/jvm/graalvm/bin
export PATH=$PATH:/snap/bin
export GOPATH=$HOME/go
