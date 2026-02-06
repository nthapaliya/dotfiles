if not set -q fish_vars_set
    echo It looks like fish has not been set up yet, run:
    echo \$ set_up_fish
    echo to finish up initializing colors and universal vars.
end
set_abbrs

if command -sq atuin
    # atuin init fish --disable-up-arrow --disable-ctrl-r | source
    atuin init fish --disable-up-arrow | source
end

# set -gx NODE_OPTIONS --openssl-legacy-provider

if command -sq fzf
    fzf --fish | source
end

if command -sq direnv
    direnv hook fish | source
end

if command -sq zoxide
    eval "$(zoxide init fish --cmd cd)"
end
