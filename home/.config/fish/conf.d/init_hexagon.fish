if not status --is-interactive
    or not command -sq hexagon
    or test (id -u) -eq 0
    exit
end

function __hexagon_handle_preexec --on-event fish_preexec
    # I think this was a rudimentary 'private mode'
    # Following the behavior of other shells I think
    # TODO: verfiy this
    if string trim --left -q "$argv"
        return
    end
    # fish_preexec and postpostexec now have the same behavior
    # re $argv: they both pass in the commandline
    # But if the PWD changes between pre and post, the postexec
    # will not be able to get the "previous pwd". Hence we
    # save it in a preexec. Ideally we can get rid of this,
    # still thinking of ideas
    set -g _hexagon_pwd "$PWD"
end

set -gx HOSTNAME $hostname

# eventually we might be able to use postexec
function __hexagon_handle_postexec --on-event fish_postexec
    # Local variables
    set prev_status $status
    set prev_duration $CMD_DURATION
    set prev_cmd (string trim "$argv")
    set prev_pwd $_hexagon_pwd

    # Clear globals
    set -e _hexagon_pwd

    test -z "$prev_pwd"
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
