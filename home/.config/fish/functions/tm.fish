# Set as Terminal.app startup command
# /usr/local/bin/tmux new-session -A -s 0

# Set as SSH command
# ssh foo@bar -t '/usr/local/bin/tmux new-session -A -s 0'

function tm
    set args $argv 0
    tmux new-session -A -s $args[1]
end
