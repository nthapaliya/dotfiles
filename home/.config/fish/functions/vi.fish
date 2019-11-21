function vi --description 'alias vi e'
    if command -sq nvim
        nvim $argv
    else if command -sq vim
        vim $argv
    else
        echo "Command not found!"
        return 1
    end
end
