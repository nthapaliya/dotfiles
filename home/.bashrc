export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="bash \[\e[36m\]\w\[\e[m\] "

export COMPATIBILITY=1

alias vi='nvim'
alias ls="ls -G"

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/Lang/rbenv/bin:$PATH
export RBENV_ROOT=$HOME/Lang/rbenv
eval "$( rbenv init - )"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.iterm2_shell_integration.bash ] && source ~/.iterm2_shell_integration.bash
