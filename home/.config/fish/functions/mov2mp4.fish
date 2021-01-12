function mov2mp4
    for filename in $argv
        if test -z $filename
            echo 'Error: Filename not specified'
            return 1
        end

        # set filters "fps=15,scale=trunc(iw/4)*2:-2:flags=lanczos"
        set filters "fps=15,scale=-2:480:flags=lanczos"
        set base (string replace -r .mov\$ '' $filename)

        ffmpeg -i $filename -lavfi "$filters" -an $base.mp4
    end
end
