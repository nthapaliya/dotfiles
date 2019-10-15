# $EDITOR
set -gx EDITOR /usr/local/bin/nvim
set -gx VISUAL $EDITOR

# $SHELL
set -gx SHELL /usr/local/bin/fish

set -gx RBENV_ROOT ~/.local/opt/rbenv
set -gx RBENV_SHELL $SHELL

set -gx CARGO_HOME ~/.local/opt/cargo
set -gx RUSTUP_HOME ~/.local/opt/rustup

set -U fish_user_paths \
    ~/.local/bin \
    ~/.local/opt/fzf/bin \
    ~/.local/opt/nvm/versions/node/v8.15.0/bin \
    $RBENV_ROOT/shims \
    $CARGO_HOME/bin

set -gx NODE_OPTIONS "--max_old_space_size=16000"

# nvm setup
set -gx NVM_DIR ~/.local/opt/nvm

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

if command -sq fd
    # fzf + fd
    set -gx FZF_DEFAULT_COMMAND 'fd -H --type file'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND 'fd -H --type directory'
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
