if not status --is-interactive
    exit
end

if not command -sq hexagon
    exit
end

function __hexagon_handle_preexec --on-event fish_preexec
    set -g _hexagon_command (string trim "$argv")
    set -g _hexagon_pwd "$PWD"
end

set -gx HOSTNAME $hostname

# once fish is updated, you can change custom_postexec to regular fish_postexec
# need work getting the command duration though
function __hexagon_handle_postexec --on-event custom_postexec
    # Local variables
    set prev_status $argv[1]
    set prev_duration $argv[2]
    set prev_cmd $_hexagon_command
    set prev_pwd $_hexagon_pwd

    # Clear globals
    set -e _hexagon_command
    set -e _hexagon_pwd

    # Sudo detection, but I'm not sure it works
    test (id -u) -eq 0
    and return

    test -z "$prev_cmd"
    and return

    if test -z "$_hexagon_shell_id"
        set -g _hexagon_shell_id (
          hexagon save \
            --pwd "$prev_pwd" \
            --command "$prev_cmd" \
            --status $prev_status \
            --duration $prev_duration )

    else
        hexagon save \
            --pwd "$prev_pwd" \
            --command "$prev_cmd" \
            --status $prev_status \
            --duration $prev_duration \
            --shell-id $_hexagon_shell_id

    end
end
