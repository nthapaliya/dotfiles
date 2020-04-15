# $EDITOR
if command -sq nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end
set -gx VISUAL $EDITOR

# $SHELL
set -gx SHELL /usr/local/bin/fish

set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache

set -U fish_user_paths \
    ~/.local/bin \
    ~/.local/opt/fzf/bin

set -gx NODE_OPTIONS "--max_old_space_size=16000"

# set -gx GOPATH ~/.local/opt/asdf/installs/golang/1.13.5/packages

# $MANPAGER
if command -sq nvim
    set -gx MANPAGER "nvim +Man!"
else
    set -gx MANPAGER "vim -M +MANPAGER -"
end

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

if test "$TERM_PROGRAM" = 'iTerm.app' && status --is-interactive
    test -e ~/.iterm2_shell_integration.fish
    and source ~/.iterm2_shell_integration.fish
    exit
end

# translation: if kitty && !tmux
if test -n "$KITTY_WINDOW_ID" -a -z "$TMUX"
    if tmux ls >/dev/null 2>/dev/null
        exec tmux attach
    else
        exec tmux new
    end
end
