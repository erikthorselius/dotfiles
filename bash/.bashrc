# Environment and PATH come before the interactive guard so that
# non-interactive ssh commands (mosh-server, scp, remote tools) see them too.
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

# Enable only in interactive shells
case $- in
  *i*) ;;
    *) return;;
esac

# Aliases
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
alias dc='docker compose'

# Dircolors + color aliases (gdircolors on macOS, dircolors on Linux)
dircolors_bin="$(command -v gdircolors || command -v dircolors)"
if [ -f ~/.dircolors ] && [ -n "$dircolors_bin" ]; then
  eval "$("$dircolors_bin" -b ~/.dircolors)"
  unset LSCOLORS
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
unset dircolors_bin

# oh-my-bash (skip silently if not installed)
export OSH="$HOME/.oh-my-bash"
if [ -r "$OSH/oh-my-bash.sh" ]; then
  OSH_THEME="powerbash10k"
  completions=(git ssh)
  aliases=(general)
  plugins=(git bashmarks)
  OMB_USE_SUDO=true
  source "$OSH/oh-my-bash.sh"
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
  . "/opt/homebrew/etc/profile.d/bash_completion.sh"
elif [[ -r /usr/share/bash-completion/bash_completion ]] && ! shopt -oq posix; then
  . /usr/share/bash-completion/bash_completion
fi

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
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Local secrets (not checked in) — see README
[ -f ~/.bash_secrets ] && source ~/.bash_secrets
