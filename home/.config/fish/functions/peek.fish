function peek
    argparse 'e/edit' -- $argv
    or return

    set name $argv[1]

    set TYPE ( type -t $name )

    test -z "$TYPE"
    and return

    if test "$TYPE" = "file"
        if test -n "$_flag_e"
            e ( type --force-path $name )
            return
        end

        type $name
        echo -----------------------------------------------------------------
        less -FX ( type --force-path $name )

        return
    end

    if test -n "$_flag_edit"
        # e ( functions $name | head -1 | cut -c14- | cut -d ' ' -f1 )
        eval ( functions $name | head -1 | cut -c14- | awk '{ print "nvim", $1, "+" $NF }' )

        return
    end

    type $name
end
