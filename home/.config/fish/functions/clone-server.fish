function clone-server
    argparse -N1 --name clone-server -x 'm,f' 'm/medium' 'f/full' 'b/nobackup' 'd/nodrop' -- $argv

    test $status -eq 0
    or return $status

    set server $argv[1]
    if test -z "$server"
        echo 'No server name provided!'
        echo 'Example: clone-server qa'
        return 1
    end


    if test -z "$_flag_nobackup"
        echo 'backing up current local database'
        set -l file ~/OSS/huddle/tmp/(date +%F--%T)-backup.sql.gz

        mysqldump -uroot officespace --hex-blob | gzip >"$file"

    else
        echo 'Skipping local backup'
    end

    if test -z "$_flag_nodrop"
        echo 'dropping local database and creating a new empty one'
        mysql -uroot --execute='drop database if exists officespace; create database officespace;'
    else
        echo 'skip dropping database officespace'
    end

    set password_script 'grep password /srv/www/huddle/shared/config/database.yml | cut -d : -f 2 | sed "s/^ *//;s/ *$//"'


    if test -n "$_flag_full"
        set ssh_command "MYSQL_PWD=\"`$password_script`\" mysqldump -u officespace -v officespace --hex-blob | gzip"

        set estimated_size 90m
    else
        set ignored_tables \
            binary_attachments \
            Floor \
            request_manager_reports \
            request_statistics_reports \
            sessions \
            webgl_logs

        set ignored_tables_cmd {--ignore-table=officespace.}{$ignored_tables}

        set mysql_dump_schema 'mysqldump -u officespace -v officespace --no-data' # all the CREATE TABLE statements
        set mysql_dump_data "mysqldump -u officespace -v officespace --no-create-info --hex-blob $ignored_tables_cmd" # only the INSERT INTO statements

        if test -n "$_flag_medium"
            set mysql_dump_floor "mysqldump -u officespace -v officespace --no-create-info --hex-blob Floor "
            set estimated_size 60m
        else
            set mysql_dump_floor "mysqldump -u officespace -v officespace --no-create-info --hex-blob Floor | sed -Ee 's/0x[0-9a-fA-F]{200,}/NULL/g'"
            set estimated_size 3m
        end

        set ssh_command "export MYSQL_PWD=\"`$password_script`\"; cat <($mysql_dump_schema) <($mysql_dump_data) <($mysql_dump_floor) | gzip"
    end

    # rsync -azvh osadmin@$server.ossd.co:/srv/www/huddle/shared/floors/ ~/OSS/huddle/floors &
    rsync -azvh osadmin@$server.ossd.co:/srv/www/huddle/shared/floors/floor_regular_\*_4x_\*.png ~/OSS/huddle/floors &
    ssh -A osadmin@$server.ossd.co "$ssh_command" | pv -s $estimated_size | gunzip | mysql -uroot officespace
    fg
end
