function mov2gif
    # http://blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
    for filename in $argv
        if test -z $filename
            echo 'Error: Filename not specified'
            return 1
        end

        set palette "/tmp/palette.png"
        set filters "fps=15,scale=iw*.5:-2:flags=lanczos"
        set palettefilters "diff_mode=rectangle:dither=sierra2"
        set base (string replace -r .mov\$ '' $filename)

        ffmpeg -v warning -i "$filename" -vf "$filters,palettegen" -y $palette
        ffmpeg -v warning -i "$filename" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse=$palettefilters" -y "$base.gif"
    end
end
