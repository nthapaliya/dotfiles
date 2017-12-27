function giphy
    if test -e $argv
        # empty
        curl --silent "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag" | jq .data.fixed_height_downsampled_url | xargs -n1 curl --progress-bar | imgcat
    else
        set -lx input ( string join + $argv )
        curl --silent "http://api.giphy.com/v1/gifs/search?limit=1&api_key=dc6zaTOxFJmzC&q=$input" | jq .data[0].images.fixed_height_downsampled.url | xargs -n1 curl --progress-bar | imgcat
    end
end
