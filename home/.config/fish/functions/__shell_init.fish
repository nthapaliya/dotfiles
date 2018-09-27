function __exec_sql
    set __histfile ~/history3.sql

    env PATH=/usr/local/opt/sqlite/bin \
        sqlite3 -cmd 'PRAGMA foreign_keys = ON;' "$__histfile" "$argv"
end

set __preexec_query_template ( string replace -a -r '\s+' ' ' "\
INSERT INTO history
    (shell_id, pwd, start_date, command)
VALUES
    (%s, '%s', strftime('%%s', 'now'), '%s') ;
SELECT last_insert_rowid() ; " )

set __posthist_query_template ( string replace -a -r '\s+' ' ' "\
UPDATE history
SET
    status = %s,
    duration = %s
WHERE
    rowid = %s AND duration IS NULL ; " )

set __exit_query_template ( string replace -a -r '\s+' ' ' "\
UPDATE shell
SET
    end_date = (strftime('%%s','now'))
WHERE
    rowid = %s ; " )

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

function __save_location_sync
    set query_template "INSERT INTO location ( latitude, longitude, h_accuracy, altitude, v_accuracy, address, create_date ) VALUES ( %s, %s, %s, %s, %s, %s, strftime('%%s', 'now') ); "

    set values ( whereami -a | jq '.latitude, .longitude, .h_accuracy, .altitude, .v_accuracy, .address' | string replace -a \' \'\' )
    set query ( printf "$query_template" $values )

    __exec_sql "$query"
end

function __handle_preexec --on-event fish_preexec
    test -z "$argv"
    and return

    test (id -u) -eq 0
    and return

    set cmdline (string replace -a \' \'\' $argv)

    set prehist_query ( printf "$__preexec_query_template" "$__shell_id" "$PWD" "$cmdline" )

    set -g __last_command_id ( __exec_sql $prehist_query )
end

function __handle_postexec --on-event custom_postexec
    set prev_status $argv[1]
    set prev_duration $argv[2]

    test (id -u) -eq 0
    and return

    test -z "$__last_command_id"
    and return

    set posthist_query ( printf "$__posthist_query_template" "$prev_status" "$prev_duration" "$__last_command_id" )

    __exec_sql $posthist_query

    set -g __last_command_id
end

function __handle_exit --on-event fish_exit
    set exit_query ( printf "$__exit_query_template" "$__shell_id" )

    __exec_sql $exit_query
end

function __set_shell_id
    set shell_start_query "$__shell_start_query_template"

    set -g __shell_id ( __exec_sql $shell_start_query )
end

function __save_env
    set env_whitelist \
        COLORTERM \
        HOME \
        LANG \
        LOGNAME \
        MAIL \
        PATH \
        PWD \
        SHELL \
        SHLVL \
        SSH_CLIENT \
        SSH_CONNECTION \
        SSH_TTY \
        TERM \
        TMUX \
        USER

    for key in $env_whitelist
        set -q $key
        or continue

        set -l val ( string replace --all \' \'\' -- $$key )

        echo "( '$key', '$val' )"
    end | string join ', ' | read -lL values

    set save_env_query ( printf "$__save_env_query_template" "$values" "$__shell_id" "$values" )

    __exec_sql $save_env_query
end

function __save_location
    command -sq whereami
    and command -sq jq
    or exit

    fish (begin
      functions __exec_sql
      functions __save_location_sync
      echo __save_location_sync
    end | psub) &
end

function __shell_init
    __set_shell_id
    __save_env
    # __save_location
end
