# translation: if !tmux then do this stuff
if test -z "$TMUX"
    if tmux ls >/dev/null 2>/dev/null
        exec tmux attach
    else
        exec tmux new
    end
end

# $EDITOR
set -gx EDITOR nvim
set -gx VISUAL $EDITOR

# $SHELL
set -gx SHELL /usr/local/bin/fish

set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache

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

if command -sq asdf
    set -gx ASDF_DATA_DIR ~/.local/opt/asdf
    source /usr/local/opt/asdf/asdf.fish
end
