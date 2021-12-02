function dns
    set -l cloudfare '1.1.1.1'
    set -l google '8.8.8.8'
    set -l pihole '192.168.0.2'

    switch $argv[1]
        case open
            sudo networksetup -setdnsservers Wi-Fi $cloudfare $google
        case pihole
            sudo networksetup -setdnsservers Wi-Fi $pihole
        case clear
            sudo networksetup -setdnsservers Wi-Fi empty
    end

    echo 'dns set to:'
    networksetup -getdnsservers Wi-Fi
end
