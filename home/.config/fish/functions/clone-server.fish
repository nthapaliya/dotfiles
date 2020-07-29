function clone-server
    argparse -N1 --name clone-server 'f/full' -- $argv

    set HUDDLE_DIR ~/OSS/huddle

    set server $argv[1]
    if test -z "$server"
        echo 'No server name provided!'
        echo 'Example: clone-server qa'
        return 1
    end

    if not type -q pv
        echo "Error: missing command `pv`. Install pv, or make sure it is in the \$PATH, and try again."
        return 1
    end

    echo 'backing up current local database'
    set date (date +%F--%T)
    set backup_file $HUDDLE_DIR/tmp/$date-backup.sql.gz
    mysqldump -uroot --databases officespace --hex-blob --add-drop-database | gzip >"$backup_file"

    set password_script 'grep password /srv/www/huddle/shared/config/database.yml | cut -d : -f 2 | sed "s/^ *//;s/ *$//"'


    if test -n "$_flag_full"
        set ssh_command "MYSQL_PWD=\"`$password_script`\" mysqldump -v -u officespace --databases officespace --add-drop-database --hex-blob | gzip"
    else
        set ignored_tables \
            binary_attachments \
            request_manager_reports \
            request_statistics_reports \
            sessions \
            webgl_logs

        set ignored_tables_cmd --ignore-table=officespace.{$ignored_tables}

        set mysql_dump_schema 'mysqldump -u officespace --databases officespace --no-data --add-drop-database' # all the CREATE TABLE statements
        set mysql_dump_data "mysqldump -u officespace officespace --no-create-info --hex-blob $ignored_tables_cmd" # only the INSERT INTO statements

        set ssh_command "export MYSQL_PWD=\"`$password_script`\"; cat <($mysql_dump_schema) <($mysql_dump_data) | gzip"
    end

    # Needs homebrew version of rsync, not the built in one
    rsync -ahz --delete --info=progress2 --no-inc-recursive osadmin@$server.ossd.co:/srv/www/huddle/shared/{photos,storage} $HUDDLE_DIR/ &

    set server_db $HUDDLE_DIR/tmp/$server-$date.sql.gz

    echo "downloading db from $server"
    ssh -A osadmin@$server.ossd.co "$ssh_command" | pv >$server_db

    echo 'loading db into mysql'
    pv $server_db | gunzip | mysql -uroot officespace
    fg
end
