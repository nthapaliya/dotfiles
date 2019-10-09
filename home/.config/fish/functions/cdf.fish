function cdf
    test -f "$argv"
    and set dir ( dirname "$argv" )
    and cd "$dir"
    and echo "$dir"
    and return

    test -d "$argv"
    and set dir "$argv"
    and cd "$dir"
    and return

    fd -H --type file --type directory |
    fzf \
        --reverse \
        --height=40% \
        --no-multi \
        --query="$argv" |
    read -l result
    or return

    test -d "$result"
    and set dir "$result"
    or set dir ( dirname "$result" )

    test -n "$dir"
    and cd "$dir"
    and echo "$dir"
end
