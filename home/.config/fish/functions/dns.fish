function dns
    set -l cloudfare '1.1.1.1'
    set -l google '8.8.8.8'
    set -l router '192.168.1.2'

    switch $argv[1]
        case open
            networksetup -setdnsservers Wi-Fi $cloudfare $google
        case close
            networksetup -setdnsservers Wi-Fi $router
    end

    echo 'dns set to:'
    networksetup -getdnsservers Wi-Fi
end
