if not set -q fish_vars_set
    echo Setting up for the first time!
    set -U fish_vars_set 1
    set_uvars
    fish_config theme choose coolbeans
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
