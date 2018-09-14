if status --is-interactive
    __shell_init
end

test -n "$FISH_CONFIG_LOADED"
and exit

set -gx FISH_CONFIG_LOADED true

function __set_fish_user_paths -d 'Helper function to set up fish_user_paths'
    for path in $argv
        if test -d $path
            and not contains $path $fish_user_paths
            set -U fish_user_paths $fish_user_paths $path
        end
    end
end

# $fish_user_paths
__set_fish_user_paths ~/.local/opt/rbenv/shims ~/.local/bin ~/.local/opt/*/bin ~/.cargo/bin

# Clear fish_greeting
set fish_greeting

# $EDITOR
set -gx EDITOR ( which nvim )
set -gx VISUAL $EDITOR

# $SHELL
# set -gx SHELL /usr/local/bin/fish

# rbenv setup
if type -q rbenv
    set -gx RBENV_ROOT ~/.local/opt/rbenv
    source (rbenv init -|psub)
end

# nvm setup
set -gx NVM_DIR ~/.local/opt/nvm
# nvm use 8.11.3

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

# Abbreviations
# work
abbr --add mqa 'env HOST=qa.ossd.co BRANCH=(gcb) bin/mina full_deploy;'
abbr --add rsqa 'rsync -azvh osadmin@qa.ossd.co:/srv/www/huddle/shared/floors/ ~/OSS/huddle/floors'
abbr --add h 'cd ~/OSS/huddle'
abbr --add p 'cd ~/Projects'
abbr --add d 'cd ~/Projects/dotfiles'
abbr --add vd 'cd ~/OSS/huddle/app/javascript/visual_directory'
abbr --add vdc 'cd ~/OSS/huddle/app/javascript/visual_directory/components'

# git
abbr --add g 'git'
abbr --add gb 'git branch'
abbr --add gcm 'git checkout master'
abbr --add gcmt 'git commit'
abbr --add gcmta 'git commit --amend --no-edit'
abbr --add gco 'git checkout'
abbr --add gd 'git diff'
abbr --add gdca 'git diff --cached'
abbr --add gss 'git status -s'

# dotfiles
abbr --add lsd 'ls -d .*'
abbr --add htree 'tree -a -I plugged\|\.git'

if type -q rg
    # fzf + rg
    set -gx FZF_CTRL_T_COMMAND 'sort -u ( rg --files | psub ) ( git ls-files | psub ) ( git status --porcelain=v2 | awk \'{print $NF}\' | psub)'
end

test "$TERM_PROGRAM" = 'iTerm.app'
and test -e ~/.iterm2_shell_integration.fish
and source ~/.iterm2_shell_integration.fish
and exit

test -z "$TMUX"
and tm
