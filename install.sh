#!/usr/bin/env bash
set -euo pipefail

FORCE=0
while getopts "f" opt; do
  case "$opt" in
    f) FORCE=1 ;;
    *) echo "Usage: $0 [-f]" >&2; exit 1 ;;
  esac
done

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src_bash="$repo_dir/.bashrc"
src_tmux="$repo_dir/.tmux.conf"
src_vim="$repo_dir/.vimrc"

target_bash="$HOME/.bashrc"
target_tmux_xdg="$HOME/.config/tmux/tmux.conf"
target_vim="$HOME/.vimrc"

link_if_needed() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$dest"
      printf 'Removed existing %s\n' "$dest"
    else
      printf 'Warning: %s already exists, skipping\n' "$dest"
      return 0
    fi
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  printf 'Linked %s -> %s\n' "$dest" "$src"
}

echo "Using repo directory: $repo_dir"

link_if_needed "$src_bash" "$target_bash"
link_if_needed "$src_tmux" "$target_tmux_xdg"
link_if_needed "$src_vim" "$target_vim"

echo "Done."
