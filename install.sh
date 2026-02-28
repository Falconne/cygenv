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

# Appends a sourcing line to dest unless the marker is already present.
# If FORCE=1, removes any existing managed block first.
# Args: dest src source_line marker
append_source_if_needed() {
  local dest="$1" src="$2" source_line="$3" marker="$4"

  if [ -f "$dest" ] && grep -qF "$marker" "$dest"; then
    if [ "$FORCE" -eq 1 ]; then
      # Remove the managed block (marker line + the line that follows it)
      sed -i "\|$marker|{N;d}" "$dest"
      printf 'Removed existing managed block from %s\n' "$dest"
    else
      printf 'Skipping %s (already managed by cygenv)\n' "$dest"
      return 0
    fi
  fi

  mkdir -p "$(dirname "$dest")"
  printf '\n%s\n%s\n' "$marker" "$source_line" >> "$dest"
  printf 'Updated %s -> sources %s\n' "$dest" "$src"
}

echo "Using repo directory: $repo_dir"

append_source_if_needed "$target_bash"     "$src_bash" "source \"$src_bash\""       "# cygenv-managed"
append_source_if_needed "$target_tmux_xdg" "$src_tmux" "source-file \"$src_tmux\""  "# cygenv-managed"
append_source_if_needed "$target_vim"      "$src_vim"  "source \"$src_vim\""        "\" cygenv-managed"

echo "Done."
