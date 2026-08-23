#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"

# Homebrew packages to install
BREW_PACKAGES=(
  stow
  git
  bash
  git-delta
  docker
  colima
)

# Dotfile directories to stow into $HOME
STOW_DIRS=(
  git
  ghostty
  bash
  tmux
)

# Install brew packages that aren't already present
install_brew_packages() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is missing. Install it first: https://brew.sh/"
    exit 1
  fi

  echo "Installing Homebrew packages..."
  for pkg in "${BREW_PACKAGES[@]}"; do
    if ! brew list "$pkg" &>/dev/null; then
      echo " - $pkg"
      brew install "$pkg"
    else
      echo " - $pkg (already installed)"
    fi
  done
}

# Symlink dotfiles into $HOME with GNU stow
stow_dotfiles() {
  echo "Stowing dotfiles..."
  for dir in "${STOW_DIRS[@]}"; do
    echo " - $dir"
    stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$dir"
  done
  echo "Done!"
}

main() {
  install_brew_packages
  stow_dotfiles
}

main "$@"

