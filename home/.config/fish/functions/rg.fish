# Make it match ag's colors
function rg
    command rg \
        --smart-case \
        --hidden \
        --colors line:fg:yellow \
        --colors line:style:bold \
        --colors path:fg:green \
        --colors path:style:bold \
        --colors match:fg:black \
        --colors match:bg:yellow \
        --colors match:style:nobold \
        $argv
end
