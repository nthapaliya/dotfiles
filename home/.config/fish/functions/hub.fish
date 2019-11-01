function hub
    env GITHUB_TOKEN=(jq -r .GITHUB_API_KEY ~/.config/creds.json) command hub $argv
end
