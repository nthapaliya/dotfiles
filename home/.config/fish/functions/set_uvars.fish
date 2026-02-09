function set_uvars
    # clean up any previously set universal vars
    set -U --names | grep -v fish_ | while read VAR
        set -e $VAR
    end

    set -e -g fish_greeting
    set -U fish_greeting

    set -e fish_user_paths
    fish_add_path ~/.local/bin
    # fish_add_path ~/go/bin # TODO: add this to .local

    if test Darwin = (uname)
        # -a so it's AFTER ~/.local/bin
        fish_add_path -a /opt/homebrew/bin
        # fish_add_path -a /opt/homebrew/opt/{coreutils,gnu-sed,gnu-time}/libexec/gnubin

        set -Ux XDG_CACHE_HOME ~/Library/Caches/xdg-cache
        set -Ux HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
    end

    # fish_add_path errors out if dir doesn't exist
    fish_add_path ~/.local/share/vim/plugged/fzf/bin
end
