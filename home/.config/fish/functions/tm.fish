function tm
    tmux attach $argv
    or tmux new $argv
end
