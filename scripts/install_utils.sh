#!/bin/bash

set -e

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)"
bin="$HOME/.local/bin"

mkdir -p "$bin"

# Symlink each utility into ~/.local/bin
for tool in "$repo"/bash_tools/*; do
  name="$(basename "$tool")"
  case "$name" in
    add_to_bashrc|ls) continue ;; # setup/discovery helpers, not runtime utils
  esac
  ln -sf "$tool" "$bin/$name"
  chmod +x "$tool"
done
