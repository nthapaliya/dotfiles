function e
    if test -n "$argv"
        eval $EDITOR $argv
    else
        echo 'Nothing to edit!'
        return 1
    end
end
