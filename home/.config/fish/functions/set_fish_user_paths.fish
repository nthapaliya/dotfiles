function set_fish_user_paths
    set -U fish_user_paths \
        ~/.local/bin \
        ~/.local/opt/{fzf}/bin \
        ~/.cargo/bin
end
