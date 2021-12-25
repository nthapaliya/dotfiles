function set_uvars
    set -e -g fish_greeting
    set -U fish_greeting

    set -U fish_user_paths \
        /opt/homebrew/bin \
        ~/.local/bin

    set -e -g SHELL
    set -Ux SHELL (which fish)

    if command -sq nvim
        set -Ux EDITOR (which nvim)
        set -Ux VISUAL $EDITOR
        set -Ux MANPAGER "nvim +Man!"
    else
        set -Ux EDITOR (which vim)
        set -Ux VISUAL $EDITOR
    end

    if test (uname) = Darwin
        set -Ux XDG_CACHE_HOME ~/Library/Caches/xdg-cache
    end

    if command -sq brew
        set -Ux HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
    end

    if command -sq fd && command -sq fzf
        set -Ux FZF_DEFAULT_COMMAND 'fd -H --type file'
        set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        set -Ux FZF_ALT_C_COMMAND 'fd -H --type directory'
    end

    if command -sq asdf
        set -Ux ASDF_DATA_DIR ~/.local/opt/asdf
    end
end
