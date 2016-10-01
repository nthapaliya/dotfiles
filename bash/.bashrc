export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="\[\e[36m\]\w\[\e[m\] "

alias vi='COMPATIBILITY=1 nvim'
alias vim='COMPATIBILITY=1 vim'
alias tmate='COMPATIBILITY=1 tmate'
alias ls="ls -G"

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/Lang/rbenv/bin:$PATH
export RBENV_ROOT=$HOME/Lang/rbenv
eval "$( rbenv init - )"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
