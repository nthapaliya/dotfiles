#!/bin/bash

# needs git
if ! command -v git > /dev/null ; then
  echo 'git not found in path'
  exit 1
fi

git clone --depth 1 git@github.com:nthapaliya/dotfiles.git "$HOME/.dotfiles"

if [[ $(uname) == 'Darwin' ]]; then
  # clone mac os bootstrap
  DOTFILES_PATH="$HOME/.dotfiles" bash scripts/macOS-bootstrap.bash
fi
# else run ubuntu version of script, which you need to write first
