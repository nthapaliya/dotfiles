function set_uvars
    # clean up any previously set universal vars
    set -U --names | grep -v fish_ | while read VAR
        set -e -g $VAR
    end

    set -e -g fish_greeting
    set -U fish_greeting

    set -U fish_user_paths ~/.local/bin

    if test Darwin = (uname)
        # TODO: Check if M1 or Intel
        set -p fish_user_paths /opt/homebrew/bin
    end

    if not command -sq fzf
        set -a fish_user_paths ~/.local/share/vim/plugged/fzf/bin
    end

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

    if command -sq fzf
        if command -sq fd
            set -Ux FZF_DEFAULT_COMMAND 'fd -H --type file'
            set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
            set -Ux FZF_ALT_C_COMMAND 'fd -H --type directory'
        else if command -sq rg
            set -Ux FZF_DEFAULT_COMMAND 'rg --files --hidden --glob \'!.git\''
            set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
        end
    end

    if command -sq asdf
        set -Ux ASDF_DATA_DIR ~/.local/opt/asdf
    end
end
