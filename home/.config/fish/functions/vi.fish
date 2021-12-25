function vi
    if command -sq nvim
        command nvim $argv
    else
        command vim $argv
    end
end
