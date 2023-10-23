function watch_run
    # fswatch -0 -o $argv[1] | xargs -0 -n1 -I{} ruby $argv[1]
    fswatch -o $argv[1] | while read
        clear
        time ruby $argv[1]
    end
end
