function vcommit
    set -l filenames
    if count $argv >/dev/null
        set filenames (git diff-tree --no-commit-id --name-only -r $argv)
    else
        set filenames (git diff-tree --no-commit-id --name-only -r HEAD)
    end

    if count $filenames >/dev/null
        eval $EDITOR $filenames
    else
        echo 'Nothing to edit!'
    end
end
