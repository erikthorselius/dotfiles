# Dotfiles

This repository contains my personal dotfiles, managed using [GNU Stow](https://www.gnu.org/software/stow/).

This README is mostly because I forget things.

## Features

- Terminal configurations (`bash`, `ghostty`, `tmux`)
- Zed editor settings (`zed`, only tracked files, not Zed state like `prompts/`)
- Git configuration
- Karabiner-Elements config and the `U.S. Svenska` keyboard layout (see below)
- Automated setup via `install.sh`

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/erikthorselius/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

### 2. Run the installer

```bash
./install.sh
```

This installs the packages and applications in `Brewfile`, then symlinks the
`bash`, `git`, `ghostty`, `tmux`, `zed`, and `karabiner` packages into `$HOME`
using GNU Stow. Existing Karabiner configuration is moved to a timestamped
backup before linking.

### Use Homebrew Bash

The installer installs Bash but does not change the login shell. On a new Mac,
add Homebrew Bash to `/etc/shells` once and select it:

```bash
brew_bash="$(brew --prefix)/bin/bash"
grep -qxF "$brew_bash" /etc/shells || echo "$brew_bash" | sudo tee -a /etc/shells
chsh -s "$brew_bash"
```

Open a new terminal afterwards and verify with `echo "$BASH_VERSION"`.

## Git identities

Git uses `erik.thorselius@gmail.com` by default. Repositories below
`~/dev/tv4/` include `~/.gitconfig-tv4` and use the TV4 email address instead.

## Swedish letters on a US keyboard

`keyboard/layouts/U.S. Svenska.keylayout` is U.S. plus å/ä/ö on keys an ANSI
keyboard lacks (ISO §, JIS ¥ and JIS _). Karabiner (`karabiner/`) sends those
keys for Caps/right ⌥ + `[` `'` `;`, so apps get å/ä/ö without Option held.
Apps that read ⌥ as Alt (Berth, WhatsApp, terminals) then type them fine.
Caps/right ⌥ + `i` `j` `k` `l` are the arrow keys.

After `./install.sh`, log out and in, then add **U.S. Svenska** under System
Settings → Keyboard → Input Sources and remove U.S.

To rebuild the layout from the current one: `swift keyboard/tools/dump-layout.swift > us.json`
then `python3 keyboard/tools/build-layout.py us.json "keyboard/layouts/U.S. Svenska.keylayout"`.

## Local secrets

Anything machine-specific or sensitive (API tokens, work-only env vars) goes
in `~/.bash_secrets`. The file is sourced at the end of `.bashrc` if present
and is intentionally not tracked by this repo.

```bash
# ~/.bash_secrets
export SOME_TOKEN=...
```
