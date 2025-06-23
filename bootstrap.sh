#!/usr/bin/env bash
set -e
REPO_ROOT=$(cd "$(dirname "$0")" && pwd)

stow --dir $REPO_ROOT --target $HOME zsh vim git

if command -v brew &>/dev/null; then
  brew bundle --no-upgrade --file=brew/Brewfile
fi

if command -v code &>/dev/null; then
  xargs -L 1 code --install-extension < vscode/vscode-extensions.txt
fi