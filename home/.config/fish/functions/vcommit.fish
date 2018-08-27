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
        set -l diff_cmd "git show --color $git_rev -- {} | diff-so-fancy"
        set filenames ( git diff-tree --no-commit-id --name-only -r $git_rev | fzf -m --reverse --preview "$diff_cmd")
    else
        set filenames ( git diff-tree --no-commit-id --name-only -r $git_rev )
    end


    if count $filenames >/dev/null
        eval $EDITOR $filenames
    else
        echo 'Nothing to edit!'
    end
end
