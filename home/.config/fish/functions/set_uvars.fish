function set_uvars
    # clean up any previously set universal vars
    set -U --names | grep -v fish_ | while read VAR
        set -e $VAR
    end

    set -e -g fish_greeting
    set -U fish_greeting

    set -e fish_user_paths
    fish_add_path ~/.local/bin
    fish_add_path ~/go/bin # TODO: add this to .local

    if test Darwin = (uname)
        # -a so it's AFTER ~/.local/bin
        fish_add_path -a /opt/homebrew/bin
        # fish_add_path -a /opt/homebrew/opt/{coreutils,gnu-sed,gnu-time}/libexec/gnubin

        set -Ux XDG_CACHE_HOME ~/Library/Caches/xdg-cache
        set -Ux HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
    end

    # fish_add_path errors out if dir doesn't exist
    fish_add_path ~/.local/share/vim/plugged/fzf/bin

    # asdf pathing
    # https://asdf-vm.com/guide/getting-started.html#_2-download-asdf
    # keep the .local/opt/asdf dir, but update the branch when installing
    # git clone https://github.com/asdf-vm/asdf.git ~/.local/opt/asdf --branch v0.10.2
    set -Ux ASDF_DIR ~/.local/opt/asdf
    set -Ux ASDF_DATA_DIR ~/.local/opt/asdf_installs
    fish_add_path $ASDF_DIR/bin $ASDF_DATA_DIR/shims

    set -Ux SHELL fish

    if command -sq nvim
        set -Ux EDITOR (which nvim)
        set -Ux VISUAL $EDITOR
        set -Ux MANPAGER "nvim +Man!"
    else
        set -Ux EDITOR (which vim)
        set -Ux VISUAL $EDITOR
    end

    if command -sq rg
        set -Ux RIPGREP_CONFIG_PATH "$HOME/.config/rg/config"
        set -Ux FZF_DEFAULT_COMMAND 'rg --files'
        set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    end

    if command -sq fd
        set -Ux FZF_ALT_C_COMMAND 'fd -H --type directory'
    end
end
