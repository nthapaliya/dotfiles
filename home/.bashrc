#!/bin/bash

export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="bash \[\e[36m\]\w\[\e[m\] "

alias vi='vim'
alias ls="ls --color=auto"

export PATH=~/.local/bin:$PATH
if [ -d /opt/homebrew/bin ] ; then export PATH=/opt/homebrew/bin:$PATH; fi

export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
