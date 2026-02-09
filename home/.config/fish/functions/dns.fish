function dns
    set -l cloudfare '1.1.1.1'
    set -l adguard '192.168.1.10'

    switch $argv[1]
        case opnsense
            sudo networksetup -setdnsservers Wi-Fi 192.168.19.1
        case clear
            sudo networksetup -setdnsservers Wi-Fi empty
    end

    echo 'dns set to:'
    networksetup -getdnsservers Wi-Fi
    echo options are `opnsense` and `clear`
end
