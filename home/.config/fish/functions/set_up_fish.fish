function set_up_fish
    echo Setting up for the first time!

    set -U fish_vars_set 1

    set_abbrs
    set_colors
    set_uvars

    # Setup fish completions
    if command -sq fzf
        eval (dirname (readlink -f (which fzf)))/../install \
            --no-completion \
            --no-update-rc \
            --key-bindings \
            --no-zsh
    end
end
