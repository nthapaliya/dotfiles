function vcommit
    test -n "$argv"
    and set git_rev ( git rev-parse $argv[1] )
    or set git_rev ( git rev-parse HEAD )

    nvim ( git diff-tree --no-commit-id --name-only -r $git_rev )
end
