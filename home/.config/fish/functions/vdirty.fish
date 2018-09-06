function vdirty
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

    test -n "$interactive"
    and set -l dirty_files ( gf $git_args )
    or set -l dirty_files ( git status -s -- $git_args | cut -c4- )

    e $dirty_files
end
