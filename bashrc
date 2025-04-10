# Enable only in interactive shells
case $- in
  *i*) ;;
    *) return;;
esac

# Platform-specific environment
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export CC=gcc

# Path setup (prepend to preserve ordering)
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:$HOME/.local/bin:$HOME/.public-bin:$HOME/bin:$HOME/go/bin:/opt/idea/bin:/usr/local/go/bin:/usr/local/sbin:$PATH"

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

# Path to oh-my-bash
export OSH="$HOME/.oh-my-bash"

# Theme
OSH_THEME="powerbash10k"

# Plugins and completions
completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)

# Enable sudo usage in OMB
OMB_USE_SUDO=true

# Source oh-my-bash
source "$OSH/oh-my-bash.sh"

