function updt
    set hfile ~/.updated
    test -f $hfile; or touch $hfile

    test (math (date +%s) - (date -r $hfile +%s)) -lt (math 7 \* 24 \* 60 \* 60); and return 1
    touch $hfile

    sudo apt update
    sudo apt upgrade
    pihole -up
    pihole restartdns
end
