function dns
    set -l quad9 '9.9.9.9'
    set -l cloudfare '1.1.1.1'
    set -l pihole '192.168.1.2'

    switch $argv[1]
        case open
            sudo networksetup -setdnsservers Wi-Fi $quad9 $cloudfare
        case pihole
            sudo networksetup -setdnsservers Wi-Fi $pihole
        case clear
            sudo networksetup -setdnsservers Wi-Fi empty
    end

    echo 'dns set to:'
    networksetup -getdnsservers Wi-Fi
    echo options are `open`, `pihole` and `clear`
end
