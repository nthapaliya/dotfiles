function __done_get_focused_window_id
    lsappinfo info -only bundleID (lsappinfo front) | cut -d '"' -f4
end

set -g __done_initial_window_id (__done_get_focused_window_id)

function __done_ended --on-event fish_prompt
    set exit_status $status
    set cmd_duration $CMD_DURATION

    test $cmd_duration -lt 60000; and return

    test "$__done_initial_window_id" = (__done_get_focused_window_id)
    and test -n "$TMUX"
    and tmux list-panes -a -F "#{session_attached} #{window_active} #{pane_pid}" | string match -q "1 1 $fish_pid"
    and return

    for i in 1000 60 60 60
        set -a l (math $cmd_duration % $i)
        set cmd_duration (math -s0 $cmd_duration / $i)
    end

    set humanized_duration (printf "%ih %im %is %ims\n" $l[4] $l[3] $l[2] $l[1] | string replace --all --regex '\b0[h|m|s] \b' '')

    set title "Done in $humanized_duration"
    set wd (string replace --regex "^$HOME" "~" (pwd))
    set subtitle "$wd/"
    set message "$history[1]"

    if test $exit_status -ne 0
        set title "Failed ($exit_status) after $humanized_duration"
    end

    terminal-notifier -message "$message" -title "$title" -subtitle "$subtitle"
end
