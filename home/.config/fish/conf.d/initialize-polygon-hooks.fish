if not status --is-interactive
    exit
end

if not command -sq polygon
    exit
end

set polygon_backup_location "$HOME/.local/share/polygon/backups"
set polygon_history_file "$HOME/.local/share/polygon/history.sqlite"

function __backup_polygon_history_now
    test -f "$polygon_history_file"
    or return 1

    mkdir -p "$polygon_backup_location"

    set backup_command ".backup $polygon_backup_location/backup-"(date +%F-%T)".sqlite"

    sqlite3 -readonly $polygon_history_file $backup_command
end

function __backup_polygon_history
    test -f "$polygon_history_file"
    or return 1

    set command "select date(start_date, 'unixepoch') != date('now') from history order by id desc limit 1"

    set should_backup (sqlite3 -readonly $polygon_history_file $command)

    if test $should_backup -eq 1
        __backup_polygon_history_now
    end
end

function __clear_variables
    set -e _start_date
    set -e _command
    set -e _pwd
end

function __polygon_handle_preexec --on-event fish_preexec
    if string trim --left -q "$argv"
        return
    end
    set -g _start_date ( date +%s )
    set -g _command (string trim "$argv")
    set -g _pwd "$PWD"
end

function __polygon_handle_postexec --on-event custom_postexec
    set _prev_status $argv[1]
    set _prev_duration $argv[2]

    test (id -u) -eq 0
    and return

    if test -z "$_command"
        __clear_variables
        return
    end

    if test -z "$_shell_id"
        __backup_polygon_history

        set -g _shell_id ( env HOSTNAME="$hostname" \
          command polygon save \
            --pwd "$_pwd" \
            --start-date "$_start_date" \
            --command "$_command" \
            --status $_prev_status \
            --duration $_prev_duration )

        __clear_variables
        return
    end

    command polygon save \
        --shell-id "$_shell_id" \
        --pwd "$_pwd" \
        --start-date "$_start_date" \
        --command "$_command" \
        --status $_prev_status \
        --duration $_prev_duration

    __clear_variables
end
