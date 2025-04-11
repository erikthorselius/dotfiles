#!/usr/bin/env bash
set -euo pipefail

# Files to ignore
IGNORED_FILES=("README" "symlink.rb" "symlink.sh")

should_ignore() {
  local filename="$1"
  for ignore in "${IGNORED_FILES[@]}"; do
    if [[ "$filename" == "$ignore" ]]; then
      return 0
    fi
  done
  return 1
}

# Create symlinks for dotfiles (excluding certain paths and files)
while IFS= read -r -d '' file; do
  filename="$(basename "$file")"
  if should_ignore "$filename"; then
    echo "Ignoring $filename"
    continue
  fi

  rel_path="${file#./}"                    # Remove leading ./
  target="$HOME/.${rel_path}"              # Dotfile path
  src="$(readlink -f "$file")"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" == "$src" ]; then
    echo "Already linked: $target"
    continue
  fi

  if [ -e "$target" ]; then
    echo "Removing existing file: $target"
    rm -rf "$target"
  fi

  echo "Linking $src -> $target"
  ln -vs "$src" "$target"
done < <(find . -type f -not -path '*/\.*' -not -path './oh-my-bash/*' -print0)

