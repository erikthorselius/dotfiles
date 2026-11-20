# Environment and PATH come before the interactive guard so that
# non-interactive ssh commands (mosh-server, scp, remote tools) see them too.
export LC_CTYPE=sv_SE.UTF-8
export EDITOR=/usr/bin/vim
export DOCKER_BUILDKIT=1

# Homebrew lives in /opt/homebrew on Apple Silicon and /usr/local on Intel.
if [ -x /opt/homebrew/bin/brew ]; then
  DOTFILES_BREW_PREFIX=/opt/homebrew
elif [ -x /usr/local/bin/brew ]; then
  DOTFILES_BREW_PREFIX=/usr/local
else
  DOTFILES_BREW_PREFIX=/opt/homebrew
fi

# Path setup
export PATH="\
$DOTFILES_BREW_PREFIX/bin:\
$DOTFILES_BREW_PREFIX/opt/e2fsprogs/bin:\
$DOTFILES_BREW_PREFIX/opt/e2fsprogs/sbin:\
$HOME/.local/bin:\
$HOME/.public-bin:\
$HOME/bin:\
$HOME/bin/tv4:\
$HOME/go/bin:\
/usr/local/go/bin:\
/usr/local/sbin:\
/Applications/IntelliJ IDEA.app/Contents/MacOS:\
$PATH"
# GNU coreutils last, so /usr/bin wins for stat, cp, ls and friends.
# Scripts assuming BSD flags (e.g. stat -f) break when GNU shadows them.
# GNU versions stay reachable via the g-prefix: gstat, gcp, gls, gdate.
export PATH="$PATH:$DOTFILES_BREW_PREFIX/opt/coreutils/libexec/gnubin:$DOTFILES_BREW_PREFIX/sbin"

# Enable only in interactive shells
case $- in
  *i*) ;;
    *) return;;
esac

# Keep PATH stable when this file is sourced more than once.
dotfiles_dedupe_path() {
  local entry deduped=
  local -a entries
  IFS=: read -r -a entries <<< "$PATH"
  for entry in "${entries[@]}"; do
    [ -n "$entry" ] || continue
    case ":$deduped:" in
      *":$entry:"*) ;;
      *) deduped="${deduped:+$deduped:}$entry" ;;
    esac
  done
  PATH="$deduped"
}

# Docker
docker_rm_all() {
  local container_ids answer
  container_ids="$(docker ps -aq)"
  if [ -z "$container_ids" ]; then
    echo "No containers to remove."
    return 0
  fi
  read -r -p "Remove all Docker containers? [y/N] " answer
  case "$answer" in
    y|Y) docker rm -f $container_ids ;;
    *) echo "Cancelled." ;;
  esac
}
alias docker-rm-all=docker_rm_all
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

if [[ -r "$DOTFILES_BREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
  . "$DOTFILES_BREW_PREFIX/etc/profile.d/bash_completion.sh"
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
if [ -s "$DOTFILES_BREW_PREFIX/opt/nvm/nvm.sh" ]; then
  \. "$DOTFILES_BREW_PREFIX/opt/nvm/nvm.sh"
  [ -s "$DOTFILES_BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$DOTFILES_BREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# Local secrets (not checked in) — see README
[ -f ~/.bash_secrets ] && source ~/.bash_secrets

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

[ -n "${NVM_BIN:-}" ] && PATH="$NVM_BIN:$PATH"
dotfiles_dedupe_path
unset -f dotfiles_dedupe_path
