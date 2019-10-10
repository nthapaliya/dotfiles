function vconflict
    if test -n "$argv"
        set git_rev ( git rev-parse $argv[1] )
    else
        set git_rev ( git rev-parse HEAD )
    end

    # e ( git diff-tree --no-commit-id --name-only -r $git_rev )
    e ( git status --short | grep '^UU' | cut -c4- )
end