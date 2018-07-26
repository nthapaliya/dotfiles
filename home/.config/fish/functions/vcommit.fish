function vcommit
    set -l filenames
    set -l git_args
    set -l interactive

    for option in $argv
        switch "$option"
            case -i --interactive
                set interactive true
            case \*
                set git_args $git_args $option
        end

    end

    # if empty, set git_args to HEAD
    if test -z "$git_args"
        set git_args HEAD
    end

    if test -n "$interactive"
        set filenames ( git diff-tree --no-commit-id --name-only -r $git_args | fzf -m --height=40% --reverse)
    else
        set filenames ( git diff-tree --no-commit-id --name-only -r $git_args )
    end


    if count $filenames >/dev/null
        eval $EDITOR $filenames
    else
        echo 'Nothing to edit!'
    end
end
