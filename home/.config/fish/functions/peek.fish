function peek
    set -l name
    set -l edit

    for option in $argv
        switch $option
            case -e --edit
                set edit true
            case \*
                set name $option
        end
    end

    set -l TYPE ( type -t $name )

    test -z "$TYPE"
    and return

    if test "$TYPE" = "file"
        if test -n "$edit"
            eval $EDITOR ( type --force-path $name )
            return
        end

        type $name
        echo -----------------------------------------------------------------
        less -FX ( type --force-path $name )

        return
    end

    if test -n "$edit"
        # eval $EDITOR ( functions $name | head -1 | cut -c14- | cut -d ' ' -f1 )
        eval ( functions $name | head -1 | cut -c14- | awk '{ print "nvim", $1, "+" $NF }' )

        return
    end

    type $name
end
