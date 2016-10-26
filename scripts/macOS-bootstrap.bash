#!/bin/bash

### README FIRST ###
# This is deliberately NOT made executable in the hope that you
# read this before running it.
# The script is not tested: In fact its best to run these line by line, manually

: ${DOTFILES_ROOT:="$HOME/.dotfiles"}

# Download and and install homebrew
if ! command -v brew > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check if homebrew installation is ok
if ! brew doctor > /dev/null; then
  echo 'brew doctor has found issues, fix these and rerun script'
  exit 1
fi

# Read brewfile and install everything (reconsider this)
# --global expects ~/.Brewfile
# if it is not there you can specify a file with --file <filename>
if ! brew bundle check --global &> /dev/null ; then
  brew bundle --global
fi

# just in case stow is not in the brewfile
if ! command -v stow > /dev/null; then
  brew install stow
fi

# will probably fail for the first time because of default bashrc
stow -R --dir="$DOTFILES_ROOT" --target="$HOME" home

# Download, rbenv and some useful plugins
# probably want to change the default, which is ~/.rbenv
if ! command -v rbenv > /dev/null ; then
  rbenv_root="${RBENV_ROOT:-$HOME/.rbenv}"
  plugins_dir="$rbenv_root/plugins"

  # install rbenv
  git clone --depth 1 https://github.com/rbenv/rbenv.git "$rbenv_root"

  # Optionally, try to compile dynamic bash extension to speed up rbenv.
  cd "$rbenv_root" && src/configure && make -C src

  mkdir -p "$plugins_dir"

  # install plugins
  git clone --depth 1 https://github.com/rbenv/ruby-build.git "$plugins_dir/ruby-build"
  git clone --depth 1 https://github.com/tpope/rbenv-ctags.git "$plugins_dir/rbenv-ctags"
  git clone --depth 1 https://github.com/rkh/rbenv-update.git "$plugins_dir/rbenv-update"
fi

# TODO: zsh helpers/link-prezto
