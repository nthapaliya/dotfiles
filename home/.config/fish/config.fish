# Global variables

# $PATH
for i in ~/.local/bin ~/Lang/rbenv/bin
  if not contains $i $PATH
    set PATH $i $PATH
  end
end

# Clear fish_greeting
set fish_greeting

# $EDITOR
set -gx EDITOR ( which nvim )
set -gx VISUAL $EDITOR

# $SHELL
# set -gx SHELL /usr/local/bin/fish

# RBENV_ROOT
set -gx RBENV_ROOT ~/Lang/rbenv
# $CDPATH
if status --is-interactive
    set -gx CDPATH . ~/Projects/ ~/OSS
end

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

# rbenv init
if not contains ~/Lang/rbenv/shims $PATH
  status --is-interactive; and source (~/Lang/rbenv/bin/rbenv init -|psub)
end

# Abbreviations
# work
abbr --add mqa 'env HOST=qa.ossd.co BRANCH=(gcb) bundle exec mina full_deploy '
abbr --add hud 'cd ~/OSS/huddle'
abbr --add vd "cd ~/OSS/huddle/app/assets/javascripts/visual_directory"
abbr --add vdc "cd ~/OSS/huddle/app/assets/javascripts/visual_directory/components"

# git
abbr --add g 'git'
abbr --add gb 'git branch'
abbr --add gcm 'git checkout master'
abbr --add gcmt 'git commit'
abbr --add gco 'git checkout'
abbr --add gdca 'git diff --cached'
abbr --add gss 'git status -s'

# dotfiles
abbr --add lsd 'ls -d .*'
abbr --add htree 'tree -a -I plugged\|\.git'
