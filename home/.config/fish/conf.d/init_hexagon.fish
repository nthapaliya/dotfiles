if not status --is-interactive
    or not command -sq hexagon
    or test (id -u) -eq 0
    exit
end

function __hexagon_handle_preexec --on-event fish_preexec
    if string trim --left -q "$argv"
        return
    end
    set -g _hexagon_command (string trim "$argv")
    set -g _hexagon_pwd "$PWD"
end

set -gx HOSTNAME $hostname

# eventually we might be able to use postexec
function __hexagon_handle_postexec --on-event fish_prompt
    # Local variables
    set prev_status $status
    set prev_duration $CMD_DURATION
    set prev_cmd $_hexagon_command
    set prev_pwd $_hexagon_pwd

    # Clear globals
    set -e _hexagon_command
    set -e _hexagon_pwd

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
