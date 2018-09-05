function __gcc
    set -q argv[1]
    and set -l git_rev $argv[1]
    or set -l git_rev HEAD

    git diff-tree --no-commit-id -r --name-only $git_rev |
    fzf \
        -m \
        --reverse \
        --preview "git show --color $git_rev -- {-1} | diff-so-fancy | tail -n +7" \
        --preview-window=down:80%
end

function vcommit
    set -l filenames
    set -l git_rev
    set -l interactive

    for option in $argv
        switch "$option"
            case -i --interactive
                set interactive true
            case \*
                set git_rev ( git rev-parse "$option" )
        end

    end

    # if empty, set git_rev to HEAD
    if test -z "$git_rev"
        set git_rev ( git rev-parse HEAD )
    end

    if test -n "$interactive"
        set filenames ( __gcc $git_rev )
    else
        set filenames ( git diff-tree --no-commit-id --name-only -r $git_rev )
    end


    if count $filenames >/dev/null
        eval $EDITOR $filenames
    else
        echo 'Nothing to edit!'
    end
end
