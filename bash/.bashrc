# Enable only in interactive shells
case $- in
  *i*) ;;
    *) return;;
esac

# Environment
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export DOCKER_BUILDKIT=1

# Path setup
export PATH="\
/opt/homebrew/bin:\
/opt/homebrew/opt/coreutils/libexec/gnubin:\
/opt/homebrew/opt/e2fsprogs/bin:\
/opt/homebrew/opt/e2fsprogs/sbin:\
$HOME/.local/bin:\
$HOME/.public-bin:\
$HOME/bin:\
$HOME/go/bin:\
/usr/local/go/bin:\
/usr/local/sbin:\
/Applications/IntelliJ IDEA.app/Contents/MacOS:\
$PATH"

# Aliases
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dc='docker compose'

# Dircolors + color aliases (only if gdircolors is available)
if [ -f ~/.dircolors ] && command -v gdircolors >/dev/null 2>&1; then
  eval "$(gdircolors -b ~/.dircolors)"
  unset LSCOLORS
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# oh-my-bash (skip silently if not installed)
export OSH="$HOME/.oh-my-bash"
if [ -r "$OSH/oh-my-bash.sh" ]; then
  OSH_THEME="powerbash10k"
  completions=(git ssh)
  aliases=(general)
  plugins=(git bashmarks)
  OMB_USE_SUDO=true
  source "$OSH/oh-my-bash.sh"
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# Eternal bash history (separate file so other sessions can't truncate it)
export HISTFILE=~/.bash_eternal_history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Local secrets (not checked in) — see README
[ -f ~/.bash_secrets ] && source ~/.bash_secrets
