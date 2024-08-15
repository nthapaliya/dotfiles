function dns
    set -l cloudfare '1.1.1.1'
    set -l adguard '192.168.1.10'

    switch $argv[1]
        case open
            sudo networksetup -setdnsservers Wi-Fi $cloudfare
        case adguard
            sudo networksetup -setdnsservers Wi-Fi $adguard
        case clear
            sudo networksetup -setdnsservers Wi-Fi empty
    end

    echo 'dns set to:'
    networksetup -getdnsservers Wi-Fi
    echo options are `open`, `adguard` and `clear`
end
