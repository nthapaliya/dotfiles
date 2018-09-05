function vdirty
    set -l dirty_files
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

    if test -n "$interactive"
        set dirty_files ( gf $git_args )
    else
        set dirty_files ( git status -s -- $git_args | cut -c4- )
    end

    if test -n "$dirty_files"
        eval $EDITOR $dirty_files
    else
        echo 'Nothing to edit!'
    end
end
