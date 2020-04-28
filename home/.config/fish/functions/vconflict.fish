function vconflict
    if test -n "$argv"
        set git_rev ( git rev-parse $argv[1] )
    else
        set git_rev ( git rev-parse HEAD )
    end

    nvim (git conflict)
end
