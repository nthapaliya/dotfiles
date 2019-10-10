function greylog
    set -l command "ssh -N -L 12900:localhost:12900 -L 9000:localhost:9000 osadmin@104.197.171.247"
    echo command is: \"$command\"
    echo "serving on: http://localhost:9000 ..."

    eval $command
end
