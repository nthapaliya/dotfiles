#!/bin/bash

### README FIRST ###
# This is deliberately NOT made executable in the hope that you
# read this before running it.
# The script is not tested: In fact its best to run these line by line, manually

: "${DOTFILES_ROOT:="$HOME/.dotfiles"}"

# Download and and install homebrew
if ! command -v brew > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Check if homebrew installation is ok
if ! brew doctor > /dev/null; then
  echo 'brew doctor has found issues, fix these and rerun script'
  exit 1
fi

brew install \
  coreutils \
  curl \
  fish \
  fzf \
  geos \
  git \
  htop \
  imagemagick \
  jq \
  mysql \
  neovim \
  rbenv \
  reattach-to-user-namespace \
  redis \
  shellcheck \
  stow \
  the_silver_searcher \
  tmate \
  tmux \
  tree \
  wget \
  yarn \
;

brew cask install \
  1password \
  cakebrew \
  daisydisk \
  dash \
  emacs \
  hipchat \
  imageoptim \
  iterm2 \
  selfcontrol \
  the-unarchiver \
  transmission \
  vlc \
;
# TODO: list other must-have packages here

# will probably fail for the first time because of default bashrc
stow -R --dir="$DOTFILES_ROOT" --target="$HOME" home
