#!/usr/bin/env bash
set -e
REPO_ROOT=$(cd "$(dirname "$0")" && pwd)

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

  if [[ "$(uname -s)" == "Darwin" ]] && command -v zed &>/dev/null; then
    install -d "$HOME/.config/zed"
    cp "$REPO_ROOT/zed/keymap.json" "$HOME/.config/zed/keymap.json"
  fi
fi
