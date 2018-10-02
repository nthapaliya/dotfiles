test -n "$FISH_CONFIG_LOADED"
and exit

set -gx FISH_CONFIG_LOADED true

# $fish_user_paths

# to clear:
# set -U fish_user_paths

# to set:
# set -U fish_user_paths \
#     ~/.local/opt/rbenv/shims \
#     ~/.local/opt/nvm/versions/node/v8.11.4/bin/ \
#     ~/.local/bin \
#     ~/.local/opt/{fzf}/bin \
#     ~/.cargo/bin

# $EDITOR
set -gx EDITOR /usr/local/bin/nvim
set -gx VISUAL $EDITOR

# $SHELL
# set -gx SHELL /usr/local/bin/fish

# rbenv setup
if command -sq rbenv && status --is-interactive
    set -gx RBENV_ROOT ~/.local/opt/rbenv
    set -gx RBENV_SHELL fish
    # source (rbenv init -|psub)
end

# nvm setup
set -gx NVM_DIR ~/.local/opt/nvm
# nvm use 8.11.3

# $MANPAGER
set -gx MANPAGER "nvim -c 'set ft=man' - "

if command -sq rg
    # fzf + rg
    set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --glob \'!.git\''
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end

if test "$TERM_PROGRAM" = 'iTerm.app' && status --is-interactive
    test -e ~/.iterm2_shell_integration.fish
    and source ~/.iterm2_shell_integration.fish
    exit
end

if test -z "$KITTY_WINDOW_ID"
    exit
end

if test -n "$TMUX"
    exit
end

if tmux ls >/dev/null 2>/dev/null
    exec tmux attach
else
    exec tmux new
end
