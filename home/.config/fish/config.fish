# $EDITOR
set -gx EDITOR /usr/local/bin/nvim
set -gx VISUAL $EDITOR

# $SHELL
set -gx SHELL /usr/local/bin/fish

set -gx RBENV_ROOT ~/.local/opt/rbenv
set -gx RBENV_SHELL $SHELL

set -U fish_user_paths \
    ~/.local/bin \
    ~/.local/opt/fzf/bin \
    ~/.local/opt/nvm/versions/node/v8.15.0/bin \
    ~/.local/opt/elasticsearch-5.4.0/bin \
    $RBENV_ROOT/shims \
    ~/.cargo/bin

set -gx NODE_OPTIONS "--max_old_space_size=16000"

# nvm setup
set -gx NVM_DIR ~/.local/opt/nvm

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

if command -sq rg
    # fzf + rg
    set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
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
