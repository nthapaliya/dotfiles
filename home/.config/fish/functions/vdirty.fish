function vdirty
    set -l dirty_files ( git status -s $argv | awk "{ print \$NF }" )
    if test -n "$dirty_files"
        eval $EDITOR $dirty_files
    else
        echo 'Nothing to edit!'
    end
end
