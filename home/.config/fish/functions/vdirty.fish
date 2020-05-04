function vdirty
    nvim ( git status -s -- $argv | cut -c4- )
end
