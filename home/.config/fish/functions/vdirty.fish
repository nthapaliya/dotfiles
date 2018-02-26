function vdirty
    set -l dirty_files ( git status -s | awk "{ print \$NF }" )
    if test -n "$dirty_files"
        eval $EDITOR $dirty_files
    else
        echo 'No dirty files!'
    end
end
