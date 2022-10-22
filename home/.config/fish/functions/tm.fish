# Some commands for quick copy-paste reference

# Set as Terminal.app startup command (MacOS)
# /usr/local/bin/tmux new-session -A -s 0

# Set as SSH command (Depends on where tmux is)
# ssh foo@bar -t '/usr/local/bin/tmux new-session -A -s 0'

# Set as et command
# et pi@raspberrypi.local --command 'tmux new-session -A -s 0'

# set as WSL startup command (Ubuntu)
# C:\Windows\system32\wsl.exe -d Ubuntu --exec /usr/bin/tmux new-session -A -s 0

function tm
    set args $argv 0
    tmux new-session -A -s $args[1]
end
