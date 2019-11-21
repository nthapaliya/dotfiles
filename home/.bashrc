export LSCOLORS='exfxcxdxbxGxDxabagacad'
export PS1="bash \[\e[36m\]\w\[\e[m\] "

alias vi='vim'
alias ls="ls -G"

export PATH=~/.local/bin:$PATH

[ -f ~/.iterm2_shell_integration.bash ] && source ~/.iterm2_shell_integration.bash
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
