function dirty
    git status -s | awk "{ print \$NF }"
end
