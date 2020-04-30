function edit --description 'edit fish functions and bash scripts in $PATH'
    set name $argv[1]
    set TYPE ( type -t $name )

    test -z "$TYPE"
    and return

    if test "$TYPE" = "file"
        nvim ( type --force-path $name )
        return
    end

    nvim ( functions --details $name )
end
