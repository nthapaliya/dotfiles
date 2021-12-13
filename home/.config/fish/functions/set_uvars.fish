function set_uvars
    set -e -g fish_greeting
    set -U fish_greeting

    set -U fish_user_paths \
        /opt/homebrew/bin \
        ~/.local/bin

    set -e -g SHELL
    set -U SHELL (which fish)

    if command -sq nvim
        set -U EDITOR nvim
        set -U VISUAL $EDITOR
        set -U MANPAGER "nvim +Man!"
    end

    if test (uname) = Darwin
        set -U XDG_CACHE_HOME ~/Library/Caches/xdg-cache
    end

    if command -sq brew
        set -U HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
    end

    if command -sq fd
        set -U FZF_DEFAULT_COMMAND 'fd -H --type file'
        set -U FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        set -U FZF_ALT_C_COMMAND 'fd -H --type directory'
    end

    if command -sq asdf
        set -U ASDF_DATA_DIR ~/.local/opt/asdf
        source /opt/homebrew/opt/asdf/libexec/asdf.fish
    end
end
