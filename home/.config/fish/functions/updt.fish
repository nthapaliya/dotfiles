function updt
    __checktime; or return 1

    if test (uname) = Darwin
        echo 'Running brew commands...'
        brew bundle dump --force --describe
        brew bundle check
    end

    topgrade
end

function __checktime
    set hfile ~/.local/share/updt/last_updated
    test -d (dirname $hfile); or mkdir -p (dirname $hfile)

    if not test -f $hfile
        touch $hfile
        return 0
    end

    test (math (date +%s) - (date -r $hfile +%s)) -lt (math 8 \* 60 \* 60); and return 1

    touch $hfile
    return 0
end
