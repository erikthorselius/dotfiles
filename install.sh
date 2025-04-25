#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"

# Homebrew-paket du vill installera
BREW_PACKAGES=(
  stow
  git
  bash
  git-delta
  docker
  colima
)

# Dotfiles-kataloger att stowa
STOW_DIRS=(
  git
  ghostty
  bash
)

# Funktion för att installera brew-paket om de inte redan finns
install_brew_packages() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew saknas! Installera det först: https://brew.sh/"
    exit 1
  fi

  echo "Installerar Homebrew-paket..."
  for pkg in "${BREW_PACKAGES[@]}"; do
    if ! brew list "$pkg" &>/dev/null; then
      echo " - $pkg"
      brew install "$pkg"
    else
      echo " - $pkg (redan installerat)"
    fi
  done
}

# Funktion för att stowa dotfiles
stow_dotfiles() {
  echo "Stowing dotfiles..."
  for dir in "${STOW_DIRS[@]}"; do
    echo " - $dir"
    stow -d "$DOTFILES_DIR" -t "$TARGET_DIR" "$dir"
  done
  echo "Klart!"
}

main() {
  install_brew_packages
  stow_dotfiles
}

main "$@"

