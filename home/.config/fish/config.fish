# Essentials:

# fish_config theme choose coolbeans
fish_add_path ~/.local/bin
set -U fish_greeting
set -gx SHELL fish
set_abbrs

# Command specific:
if command -sq atuin
    # atuin init fish --disable-up-arrow --disable-ctrl-r | source
    atuin init fish --disable-up-arrow | source
end

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

if command -sq fzf
    fzf --fish | source
end

# OS Specific
if test Darwin = (uname)
    fish_add_path -a /opt/homebrew/bin

    set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache
    set -gx HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
end

# set -gx NODE_OPTIONS --openssl-legacy-provider
