test -n "$FISH_CONFIG_LOADED" ; and exit ;
set -gx FISH_CONFIG_LOADED true

# Global variables

# $PATH
for i in ~/.local/bin ~/Lang/racket/bin
    set PATH $i $PATH
end

# Clear fish_greeting
set fish_greeting

# $EDITOR
set -gx EDITOR ( which nvim )
set -gx VISUAL $EDITOR

# $SHELL
# set -gx SHELL /usr/local/bin/fish

if status --is-interactive
    # $CDPATH
    set -gx CDPATH . ~/Projects/ ~/OSS

    # rbenv setup
    set -gx RBENV_ROOT ~/Lang/rbenv
    source (rbenv init -|psub)
end

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

# Abbreviations
# work
abbr --add mqa 'env HOST=qa.ossd.co BRANCH=(gcb) bin/mina full_deploy;'
abbr --add hud 'cd ~/OSS/huddle'
abbr --add vd "cd ~/OSS/huddle/app/assets/javascripts/visual_directory"
abbr --add vdc "cd ~/OSS/huddle/app/assets/javascripts/visual_directory/components"

# git
abbr --add g 'git'
abbr --add gb 'git branch'
abbr --add gcm 'git checkout master'
abbr --add gcmt 'git commit'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gdca 'git diff --cached'
abbr --add gss 'git status -s'

# dotfiles
abbr --add lsd 'ls -d .*'
abbr --add htree 'tree -a -I plugged\|\.git'


# fzf + rg
set -gx FZF_DEFAULT_COMMAND 'rg --files .'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
