function edit_config
    set config ~/.config/fish/config.fish
    nvim $config
    and source $config
end
