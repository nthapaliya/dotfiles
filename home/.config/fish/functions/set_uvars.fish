function set_uvars
    # clean up any previously set universal vars
    set -U --names | grep -v fish_ | while read VAR
        set -e $VAR
    end

    set -e -g fish_greeting
    set -U fish_greeting

    fish_add_path ~/.local/bin

    if test Darwin = (uname)
        # TODO: Check if M1 or Intel
        # -a so it's AFTER ~/.local/bin
        fish_add_path -a /opt/homebrew/bin
    end

    if not command -sq fzf
        # what is this?
        fish_add_path ~/.local/share/vim/plugged/fzf/bin
    end

    set -Ux SHELL fish

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
