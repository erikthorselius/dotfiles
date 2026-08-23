# Dotfiles

This repository contains my personal dotfiles, managed using [GNU Stow](https://www.gnu.org/software/stow/).

This README is mostly because I forget things. 
## Features

- Terminal configurations (`bash`, `ghostty`, `tmux`)
- Git configuration
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

This installs the required Homebrew packages and symlinks each subdirectory
(`bash`, `git`, `ghostty`, `tmux`) into `$HOME` using GNU Stow.

## Local secrets

Anything machine-specific or sensitive (API tokens, work-only env vars) goes
in `~/.bash_secrets`. The file is sourced at the end of `.bashrc` if present
and is intentionally not tracked by this repo.

```bash
# ~/.bash_secrets
export SOME_TOKEN=...
```
