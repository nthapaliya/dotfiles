test (uname) = 'Darwin'; or exit

function humanized_duration
    set duration $argv[1]

    set ms (math -s0 $duration % 1000)
    set duration (math -s0 $duration / 1000)

    set ss (math -s0 $duration % 60)
    set duration (math -s0 $duration / 60)

    set mm (math -s0 $duration % 60)
    set duration (math -s0 $duration / 60)

    set hh (math -s0 $duration % 24)
    set duration (math -s0 $duration / 24)

    set dd $duration

    test $dd -ne 0; and set -a values "$dd"d
    test $hh -ne 0; and set -a values "$hh"h
    test $mm -ne 0; and set -a values "$mm"m
    test $ss -ne 0; and set -a values "$ss"s
    set -a values "$ms"ms

    string join ' ' $values
end

function __done_get_focused_window_id
    set tm_format "#{session_attached} #{window_active} #{pane_active} #{pane_pid}"
    set prefix (lsappinfo info -only bundleID (lsappinfo front) | cut -d '"' -f4)

    test "$TERM_PROGRAM" = 'Apple_Terminal'
    and set __suffix "$TERM_SESSION_ID"

    test -n "$TMUX"
    and set __suffix (
      tmux list-panes -a -F "$tm_format" |
      string match -r '^1 1 1 (\d+)$' |
      tail -1
    )

    printf "$prefix_$__suffix"
end

set -g __done_initial_window_id (__done_get_focused_window_id)

function __done_ended --on-event fish_prompt
    set exit_status $status
    set cmd_duration $CMD_DURATION

    test $cmd_duration -lt 10000; and return

    test "$__done_initial_window_id" = (__done_get_focused_window_id)
    and return

    set duration (humanized_duration $cmd_duration)

    set title "Done in $duration"
    set wd (string replace --regex "^$HOME" "~" (pwd))
    set subtitle "$wd/"
    set message "$history[1]"

    if test $exit_status -ne 0
        set title "Failed ($exit_status) after $duration"
    end

    terminal-notifier -message "$message" -title "$title" -subtitle "$subtitle"
end
