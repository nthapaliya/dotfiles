function e
    if test -n "$argv"
        if command -sq $EDITOR
            eval $EDITOR $argv
        else
            command vim $argv
        end
    else
        echo 'Nothing to edit!'
        return 1
    end
end
