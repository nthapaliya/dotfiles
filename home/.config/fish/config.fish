# set_uvars
set_abbrs

if command -sq atuin
    # atuin init fish --disable-up-arrow --disable-ctrl-r | source
    atuin init fish --disable-up-arrow | source
end

# set -gx NODE_OPTIONS --openssl-legacy-provider

if command -sq fzf
    fzf --fish | source
end

if command -sq direnv
    direnv hook fish | source
end

fish_config theme choose dracula

set -gx SHELL fish

if command -sq nvim
    set -gx EDITOR (which nvim)
    set -gx VISUAL $EDITOR
    set -gx MANPAGER "nvim +Man!"
else
    set -gx EDITOR (which vim)
    set -gx VISUAL $EDITOR
end

if command -sq rg
    set -gx RIPGREP_CONFIG_PATH "$HOME/.config/rg/config"
    set -gx FZF_DEFAULT_COMMAND 'rg --files'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end

if command -sq fd
    set -gx FZF_ALT_C_COMMAND 'fd -H --type directory'
end
