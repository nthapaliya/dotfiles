# $EDITOR
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

# $SHELL
set -gx SHELL /usr/local/bin/fish

set -U fish_user_paths \
    ~/.local/bin

set -gx NODE_OPTIONS "--max_old_space_size=16000"

# $MANPAGER
set -gx MANPAGER "nvim +Man!"

# Brewfile
set -gx HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile

if command -sq fd
    # fzf + fd
    set -gx FZF_DEFAULT_COMMAND 'fd -H --type file'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND 'fd -H --type directory'
end

test -e ~/.asdf/asdf.fish
and source ~/.asdf/asdf.fish
