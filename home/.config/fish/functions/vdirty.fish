function vdirty
    eval $EDITOR ( git status -s | awk "{ print \$NF }" )
end
