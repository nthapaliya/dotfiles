function rl
    rg \
        --color=always \
        --no-heading \
        $argv |
    __fzf_down \
        --bind="ctrl-e:execute( nvim {+1} -c'/$argv' >/dev/tty ),ctrl-a:select-all+accept" \
        --delimiter=: \
        --preview '' |
    cut -d: -f1 | sort | uniq
end

# TODO:
# Add description
# Add caption/hint/header showing ctrl-e is an option
# Play with this for a while, see how it feels. Maybe rename function
