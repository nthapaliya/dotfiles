function set_up_fish
    echo Setting up for the first time!

    set -U fish_vars_set 1

    set_uvars

    fish_config theme choose coolbeans

    if command -sq kitty
        kitty +kitten themes --config-file-name=theme.conf Catppuccin-Macchiato
    end

    # Setup fish completions
    if command -sq fzf
        eval (dirname (readlink -f (which fzf)))/../install \
            --no-completion \
            --no-update-rc \
            --key-bindings \
            --no-zsh
    end
end
