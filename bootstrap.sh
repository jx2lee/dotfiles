#!/usr/bin/env bash
set -e
REPO_ROOT=$(cd "$(dirname "$0")" && pwd)
CURRENT_TIMESTAMP=$(date -u '+%Y-%m-%dT%H:%M:%SZ')

stow --dir $REPO_ROOT --target $HOME zsh vim git tmux

if [[ "$1" == "--install-packages" ]]; then
  if command -v brew &>/dev/null; then
    brew bundle --no-upgrade --file=brew/Brewfile
  fi

  if command -v code &>/dev/null; then
    # install extension when not current installed && to install extensions
    comm -23 \
      <(sort vscode/vscode-extensions.txt) \
      <(code --list-extensions --show-versions 2>/dev/null | sort) \
      | xargs -r -L 1 code --install-extension
  fi
fi

# Editor: Zed
if [[ "$(uname -s)" == "Darwin" ]] && command -v zed &>/dev/null; then
BACKUPS=()
for file in settings.json keymap.json; do
    target="$HOME/.config/zed/$file"
    [[ -L "$target" && "$target" -ef "$REPO_ROOT/zed/.config/zed/$file" ]] && continue
    [[ -e "$target" || -L "$target" ]] || continue
    backup="$target.$CURRENT_TIMESTAMP.backup"
    if [[ ( ! -L "$target" && ! -f "$target" ) || -e "$backup" || -L "$backup" ]]; then
    printf 'Cannot back up %s: unexpected file type or backup already exists\n' "$target" >&2
    exit 1
    fi
    BACKUPS+=("$target")
done
# Backup existing files for zed
for target in "${BACKUPS[@]}"; do
    mv -n "$target" "$target.$CURRENT_TIMESTAMP.backup"
    if [[ -e "$target" || -L "$target" ]]; then
    printf 'Could not back up: %s\n' "$target" >&2
    exit 1
    fi
done
stow --no-folding --dir "$REPO_ROOT" --target "$HOME" zed
fi
