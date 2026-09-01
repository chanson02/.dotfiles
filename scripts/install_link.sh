#!/bin/bash

set -e

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"

# Symlink each item in config/ into ~/.config
mkdir -p "$HOME/.config"

for item in "$dotfiles"/config/*; do
  [ -e "$item" ] || continue
  name="$(basename "$item")"
  target="$(readlink -f "$item")"

  # Don't overwrite existing non-symlink directories
  if [ -e "$HOME/.config/$name" ] && [ ! -L "$HOME/.config/$name" ]; then
    echo "WARNING: ~/.config/$name exists and is not a symlink, skipping"
    continue
  fi

  ln -sfn "$target" "$HOME/.config/$name"
  echo "linked ~/.config/$name -> $target"
done

# Symlink gitconfig (dotfile, so not caught by the config/* glob above)
ln -sfn "$dotfiles/config/.gitconfig" "$HOME/.gitconfig"
echo "linked ~/.gitconfig -> $dotfiles/config/.gitconfig"
