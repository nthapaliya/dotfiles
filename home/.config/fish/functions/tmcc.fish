function tmcc
    tmux -f /dev/null -CC attach $argv
    or tmux -f /dev/null -CC new $argv
end
