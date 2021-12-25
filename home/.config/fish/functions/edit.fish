function edit --description 'edit fish functions and bash scripts in $PATH'
    set name $argv[1]

    if test "$name" = config
        set config ~/.config/fish/config.fish
        vi $config
        and source $config
        return
    end

    set TYPE ( type -t $name )

    test -z "$TYPE"; and return

    if test "$TYPE" = file
        if string match -q binary (file -b --mime-encoding (which $name))
            echo 'binary file!'
            return 1
        end

        vi ( type --force-path $name )
        return 0
    end

    vi ( functions --details $name )
end
