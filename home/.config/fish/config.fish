if not set -q fish_vars_set
    set -U fish_vars_set 1

    set_up_fish
end

if command -sq asdf
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
end
