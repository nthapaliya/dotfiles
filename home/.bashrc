#!/bin/bash

export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="bash \[\e[36m\]\w\[\e[m\] "

alias vi='vim'
alias ls="ls -G"

export PATH=/opt/homebrew/bin:~/.local/bin:$PATH
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
