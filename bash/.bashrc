# Enable only in interactive shells
case $- in
  *i*) ;;
    *) return;;
esac

# Platform-specific environment
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim

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

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Append to history file instead of overwriting
shopt -s histappend
# Save multi-line commands as a single entry
shopt -s cmdhist
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export DOCKER_BUILDKIT=1
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Load secrets (not checked in)
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi
