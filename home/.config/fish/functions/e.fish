function e
    test -n "$argv"
    and eval $EDITOR $argv
    or echo 'Nothing to edit!'
end
