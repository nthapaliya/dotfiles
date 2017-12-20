export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="bash \[\e[36m\]\w\[\e[m\] "

alias vi='nvim'
alias ls="ls -G"

export PATH=~/.local/bin:/usr/local/bin:$PATH

export IS_MOSH=$(is_mosh --verbose)

[ -f ~/.iterm2_shell_integration.bash ] && source ~/.iterm2_shell_integration.bash
