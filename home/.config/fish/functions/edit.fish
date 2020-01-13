function edit --description 'alias edit peek'

    set name $argv[1]

    set TYPE ( type -t $name )

    test -z "$TYPE"
    and return

    if test "$TYPE" = "file"
        e ( type --force-path $name )
        return
    end

    # e ( functions $name | head -1 | cut -c14- | cut -d ' ' -f1 )
    eval ( functions $name | head -1 | cut -c14- | awk '{ print "vi", $1, "+" $NF }' )
end
