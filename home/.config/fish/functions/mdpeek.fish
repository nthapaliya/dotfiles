# https://gist.github.com/atelierbram/09c8fb742f1518f09ff9e4338ab8f7fb
function mdpeek
    set -l input $argv[1]

    # TODO: fail if $argv[1] is not supplied
    if not test -e "$input"
        echo "usage: mdpeek input_file.md"
        return 1
    end
    set -l output /tmp/(basename --suffix=.md $input).html

    pandoc --embed-resources=true \
        --standalone=true \
        --from markdown \
        --to html5 \
        --css "https://latex.vercel.app/style.css" \
        --output $output \
        $input

    open $output
end
