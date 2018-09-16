function gbrowse
    set url ( git config --list | sed -nEe 's/^remote.origin.url=(https:\/\/github.com\/|git@github.com:)([^.]+)(\.git)?/\2/p' )

    if test -z "$argv"
        set rev ( git rev-parse --short HEAD )
    else
        set rev ( git rev-parse --short "$argv")
    end

    open "https://github.com/$url/commit/$rev"
end