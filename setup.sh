#!/bin/bash

DOTFILES_LOCATION=$HOME/.dotfiles/

ln -s $DOTFILES_LOCATION/vim/.vimrc $HOME/.vimrc
ln -s $DOTFILES_LOCATION/vim/.vim $HOME/.vim
ln -s $DOTFILES_LOCATION/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES_LOCATION/tmux/.tmate.conf $HOME/.tmate.conf
