function conflict
    git status -s | grep UU | cut -d " " -f 2 $argv
end
