#!/bin/bash

# Checking for binaries first
hash stow 2>/dev/null || {
  echo 'Error! Missing command'
  hash brew 2>/dev/null &&
    printf 'Run "brew install stow"' ||
    printf 'Use your package manager to install gnu stow'
  echo ' and run this script again'
  exit 1
}

# Actually making the symlinks
#
case $1 in
  --install|-i)
    stow -R bash git ruby vim tmux
    ;;
  --uninstall|-u)
    stow -D bash git ruby vim tmux
    ;;
  *)
    echo $"Usage: $0 {--install|--uninstall}"
    exit 1
  esac