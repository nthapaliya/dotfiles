function __gcc
    set -q argv[1]
    and set git_rev $argv[1]
    or set git_rev HEAD

    git diff-tree --no-commit-id -r --name-only $git_rev |
    fzf \
        -m \
        --reverse \
        --preview "git show --color $git_rev -- {-1} | diff-so-fancy | tail -n +7" \
        --preview-window=down:80%
end

function vcommit
    argparse 'i/interactive' -- $argv

    test -n "$argv"
    and set git_rev ( git rev-parse $argv[1] )
    or set git_rev ( git rev-parse HEAD )

    test -n "$_flag_interactive"
    and set filenames ( __gcc $git_rev )
    or set filenames ( git diff-tree --no-commit-id --name-only -r $git_rev )

    e $filenames
end
