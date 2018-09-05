function __fzf_down
    fzf \
        --ansi \
        --exit-0 \
        --multi \
        --preview-window=down:80% \
        --reverse \
        $argv
    # tee /dev/tty |
    # pbcopy
end
