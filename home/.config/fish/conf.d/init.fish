if not status --is-interactive
    exit
end

function _sfh
    /Users/niraj/Projects/advanced-fish-history/bin/main $argv
end

function __handle_preexec --on-event fish_preexec
    test -z "$argv"
    and return

    test (id -u) -eq 0
    and return

    # handle this before the first command, to make
    # shell init feel snappier
    if test -z "$__shell_id"
        set -g __shell_id ( _sfh shell-start )
    end

    set -g __last_command_id (
    _sfh pre-exec \
      --command "$argv" \
      --shell-id $__shell_id
    )
end

function __handle_postexec --on-event custom_postexec
    set prev_status $argv[1]
    set prev_duration $argv[2]

    test (id -u) -eq 0
    and return

    test -z "$__last_command_id"
    and return

    /Users/niraj/Projects/advanced-fish-history/bin/main post-exec \
        --duration $prev_duration \
        --status $prev_status \
        --history-id $__last_command_id &
    set -g __last_command_id
end

# function __handle_exit --on-event fish_exit
#     _sfh shell-exit --shell-id $__shell_id
# end
