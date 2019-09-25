function clone-server
    argparse -N1 --name clone-server 'f/full' -- $argv

    test $status -eq 0
    or return $status

    set server $argv[1]
    if test -z "$server"
        echo 'No server name provided!'
        echo 'Example: clone-server qa'
        return 1
    end

    echo 'backing up current local database'
    set backup_file ~/OSS/huddle/tmp/(date +%F--%T)-backup.sql.gz
    mysqldump -uroot --databases officespace --hex-blob --add-drop-database | gzip >"$backup_file"

    set password_script 'grep password /srv/www/huddle/shared/config/database.yml | cut -d : -f 2 | sed "s/^ *//;s/ *$//"'


    if test -n "$_flag_full"
        set ssh_command "MYSQL_PWD=\"`$password_script`\" mysqldump -v -u officespace --databases officespace --add-drop-database --hex-blob | gzip"
        rsync -azvh osadmin@$server.ossd.co:/srv/www/huddle/shared/floors/ ~/OSS/huddle/floors &

        set estimated_size 95m
    else
        set ignored_tables \
            binary_attachments \
            Floor \
            request_manager_reports \
            request_statistics_reports \
            sessions \
            webgl_logs

        set ignored_tables_cmd {--ignore-table=officespace.}{$ignored_tables}

        set mysql_dump_schema 'mysqldump -u officespace --databases officespace --no-data --add-drop-database' # all the CREATE TABLE statements
        set mysql_dump_data "mysqldump -u officespace officespace --no-create-info --hex-blob $ignored_tables_cmd" # only the INSERT INTO statements
        set mysql_dump_floor "mysqldump -u officespace officespace --no-create-info --hex-blob Floor | sed -Ee 's/0x[0-9a-fA-F]{200,}/0xffffff/g'"
        set estimated_size 4m

        set ssh_command "export MYSQL_PWD=\"`$password_script`\"; cat <($mysql_dump_schema) <($mysql_dump_data) <($mysql_dump_floor) | gzip"
        rsync -azvh osadmin@$server.ossd.co:/srv/www/huddle/shared/floors/floor_regular_\*_4x_\*.png ~/OSS/huddle/floors &
    end

    rsync -azvh osadmin@$server.ossd.co:/srv/www/huddle/shared/photos ~/OSS/huddle/ &

    ssh -A osadmin@$server.ossd.co "$ssh_command" | pv -s $estimated_size | gunzip | mysql -uroot officespace
    fg
    fg
end
