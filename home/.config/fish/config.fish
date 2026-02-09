# set_uvars
# fish_config theme choose coolbeans
set_abbrs

if command -sq atuin
    # atuin init fish --disable-up-arrow --disable-ctrl-r | source
    atuin init fish --disable-up-arrow | source
end

if command -sq fzf
    fzf --fish | source
end

if command -sq direnv
    direnv hook fish | source
end

if command -sq zoxide
    eval "$(zoxide init fish --cmd cd)"
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

if test Darwin = (uname)
    fish_add_path -a /opt/homebrew/bin

    set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache
    set -gx HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
end

fish_add_path ~/.local/bin
set -e fish_greeting
set -gx SHELL fish
# set -gx NODE_OPTIONS --openssl-legacy-provider
