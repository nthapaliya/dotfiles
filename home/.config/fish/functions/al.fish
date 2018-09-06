function al
    # rg --files-with-matches --smart-case $argv
    rg \
        --color=always \
        --no-heading \
        --smart-case \
        $argv |
    __fzf_down \
        --bind="ctrl-e:execute( nvim {+1} -c'/$argv' )" \
        --delimiter=: \
        --preview '' |
    cut -d: -f1 | sort | uniq
end

# TODO:
# Add description
# Add caption/hint/header showing ctrl-e is an option
# Play with this for a while, see how it feels. Maybe rename function
