function edit_config
    set config ~/.config/fish/config.fish
    e $config
    and source $config
end
