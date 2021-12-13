function edit --description 'edit fish functions and bash scripts in $PATH'
    set name $argv[1]

    if test "$name" = config
        set config ~/.config/fish/config.fish
        nvim $config
        and source $config
        return
    end

    set TYPE ( type -t $name )

    test -z "$TYPE"
    and return

    if test "$TYPE" = file
        nvim ( type --force-path $name )
        return
    end

    nvim ( functions --details $name )
end
