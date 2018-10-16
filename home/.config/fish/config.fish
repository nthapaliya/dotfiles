# $EDITOR
set -gx EDITOR /usr/local/bin/nvim
set -gx VISUAL $EDITOR

set -gx RBENV_ROOT ~/.local/opt/rbenv
set -gx RBENV_SHELL fish

if not contains $RBENV_ROOT/shims $fish_user_paths
    set --prepend fish_user_paths $RBENV_ROOT/shims
end

# $SHELL
set -gx SHELL /usr/local/bin/fish

# nvm setup
set -gx NVM_DIR ~/.local/opt/nvm

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

# translation: if kitty && !tmux
if test -n "$KITTY_WINDOW_ID" -a -z "$TMUX"
    if tmux ls >/dev/null 2>/dev/null
        exec tmux attach
    else
        exec tmux new
    end
end
