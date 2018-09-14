set __histfile ~/history.sql

set __preexec_query_template ( string replace -a -r '\s+' ' ' "\
INSERT INTO history
    (shell_id, pwd, start_date, command)
VALUES
    (%s, '%s', strftime('%%s', 'now'), '%s') ;
SELECT last_insert_rowid() ; " )

set __posthist_query_template ( string replace -a -r '\s+' ' ' "\
UPDATE history
SET
    end_date = (strftime('%%s','now')),
    status = %s,
    duration = %s
WHERE
    id = %s AND end_date IS NULL ; " )

set __exit_query_template ( string replace -a -r '\s+' ' ' "\
UPDATE shell
SET
    end_date = (strftime('%%s','now'))
WHERE
    id = %s ; " )

set __save_env_query_template ( string replace -a -r '\s+' ' ' "\
INSERT OR IGNORE INTO env
    ( key, value )
VALUES
    %s ;

INSERT into shell_to_env
    ( shell_id, env_id )
SELECT %s, id FROM env WHERE
    ( key, value ) IN ( VALUES %s ); " )

set __shell_start_query_template ( string replace -a -r '\s+' ' ' "\
INSERT INTO shell
    (start_date, utc_offset)
VALUES
    (strftime('%s', 'now'), (strftime('%s', 'now', 'localtime') - strftime('%s', 'now'))) ;
SELECT last_insert_rowid() ; " )

function __prehist --on-event fish_preexec
    test -z "$argv"
    and return

    test (id -u) -eq 0
    and return

    set -l cmdline (string replace -a \' \'\' $argv)

    set -l prehist_query ( printf "$__preexec_query_template" "$__shell_id" "$PWD" "$cmdline" )

    set -g __last_command_id ( command sqlite3 $__histfile "$prehist_query" )
end

function __posthist --on-event custom_postexec
    set -l prev_status $argv[1]
    set -l prev_duration $argv[2]

    test -z "$__last_command_id"
    and return

    test (id -u) -eq 0
    and return

    set -l posthist_query ( printf "$__posthist_query_template" "$prev_status" "$prev_duration" "$__last_command_id" )

    command sqlite3 $__histfile "$posthist_query"

    set -g __last_command_id
end

function __on_exit --on-event fish_exit
    set -l exit_query ( printf "$__exit_query_template" "$__shell_id" )

    command sqlite3 $__histfile "$exit_query"
end

function __save_env
    set -l save_env_query
    begin
        set -l pairs
        env | while read line
            set -l pair (string split -m 1 '=' "$line")
            set -l key "$pair[1]"
            set -l val ( string replace --all \' \'\' "$pair[2]" )

            set -a pairs "( '$key', '$val' )"
        end
        set -l values ( string join ', ' $pairs )

        set save_env_query ( printf "$__save_env_query_template" "$values" "$__shell_id" "$values" )
    end

    command sqlite3 $__histfile "$save_env_query"
end

function __set_shell_id
    set -l shell_start_query "$__shell_start_query_template"

    set -g __shell_id ( command sqlite3 $__histfile "$shell_start_query" )
end

function __shell_init
    __set_shell_id
    __save_env
end
