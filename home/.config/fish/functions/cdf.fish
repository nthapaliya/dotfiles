# TODO: tweak fzf params so its not so juddery
function cdf
    test -f "$argv"
    and set -l dir ( dirname "$argv" )
    and cd "$dir"
    and echo "$dir"
    and return

    test -d "$argv"
    and set -l dir "$argv"
    and cd "$dir"
    and return

    sort -mu ( rg --files --sort-files . | psub ) ( git ls-files | psub ) ( git ls-tree -d -r HEAD --name-only | psub ) |
    fzf \
        --no-multi \
        --query="$argv" |
    read -l result
    or return

    test -d "$result"
    and set -l dir "$result"
    or set -l dir ( dirname "$result" )

    test -n "$dir"
    and cd "$dir"
    and echo "$dir"
end
