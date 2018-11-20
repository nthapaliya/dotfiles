function __cache_or_get_rake_completion -d "Create rake completions"
    set rakefile_hash (__hashed_rakefiles)
    set cache_location $HOME/.cache/fish/completions/rake
    set rake_cache_file "$cache_location/$rakefile_hash"

    mkdir -p $cache_location

    if not test -f "$rake_cache_file"
        rake -T 2>&1 | sed -e "s/^rake \([a-z:_0-9!\-]*\).*#\(.*\)/\1	\2/" >"$rake_cache_file"
    end
    cat "$rake_cache_file"
end

function __run_rake_completion
    test -f rakefile
    or test -f Rakefile
    or test -f rakefile.rb
    or test -f Rakefile.rb
end

function __hashed_rakefiles
    begin
        echo $PWD
        for file in rakefile Rakefile rakefile.rb Rakefile.rb
            test -e $file
            and echo "$file"
            and cat $file
        end
        for file in lib/**/*.rake
            echo $file
            cat $file
        end
    end | fish_md5
end

complete -n __run_rake_completion \
    -x -c rake -a "(__cache_or_get_rake_completion)"
