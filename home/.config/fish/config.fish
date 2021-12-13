if not set -q fish_vars_set
    set -U fish_vars_set 1

    echo Setting up for the first time!
    set_abbrs
    set_colors
    set_uvars

    # Setup fish completions
    if command -sq fzf
        eval (brew --prefix)/opt/fzf/install \
            --no-completion \
            --no-update-rc \
            --key-bindings \
            --no-bash \
            --no-zsh
    end
end
