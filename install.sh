#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME"
BREWFILE="$DOTFILES_DIR/Brewfile"

# Dotfile directories to stow into $HOME
STOW_DIRS=(
  git
  ghostty
  bash
  tmux
  zed
  karabiner
)

# Install brew packages that aren't already present
install_brew_packages() {
  if ! command -v brew &>/dev/null; then
    echo "Homebrew is missing. Install it first: https://brew.sh/"
    exit 1
  fi

  echo "Installing Homebrew packages..."
  brew bundle --no-upgrade --file="$BREWFILE"
}

# Symlink dotfiles into $HOME with GNU stow
stow_dotfiles() {
  echo "Stowing dotfiles..."
  # Pre-create so stow links files, not the whole dir (Zed keeps state there)
  mkdir -p "$TARGET_DIR/.config/zed"
  # Karabiner replaces karabiner.json on save, so the whole dir must be the symlink
  if [[ -d "$TARGET_DIR/.config/karabiner" && ! -L "$TARGET_DIR/.config/karabiner" ]]; then
    mv "$TARGET_DIR/.config/karabiner" "$TARGET_DIR/.config/karabiner.backup.$(date +%Y%m%d%H%M%S)"
  fi
  echo "Checking for conflicts..."
  stow --simulate --restow -d "$DOTFILES_DIR" -t "$TARGET_DIR" "${STOW_DIRS[@]}"
  stow --restow -d "$DOTFILES_DIR" -t "$TARGET_DIR" "${STOW_DIRS[@]}"
  echo "Done!"
}

# Keyboard layouts are copied, macOS ignores symlinked ones
install_keyboard_layouts() {
  echo "Installing keyboard layouts..."
  local dest="$HOME/Library/Keyboard Layouts"
  mkdir -p "$dest"
  for layout in "$DOTFILES_DIR"/keyboard/layouts/*.keylayout; do
    echo " - $(basename "$layout")"
    cp "$layout" "$dest/"
  done
}

main() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    echo "This installer currently supports macOS only."
    exit 1
  fi

  install_brew_packages
  stow_dotfiles
  install_keyboard_layouts
}

main "$@"

