function __cache_or_get_rake_completion -d "Create rake completions"
  set -l rakefile_hash (__hashed_rakefiles)
  set -l cache_location $HOME/.cache/fish/completions/rake
  mkdir -p $cache_location
  set -l rake_cache_file "$cache_location/$rakefile_hash"

  if not test -f "$rake_cache_file"
    rake -T 2>&1 | sed -e "s/^rake \([a-z:_0-9!\-]*\).*#\(.*\)/\1	\2/" > "$rake_cache_file"
  end
  cat "$rake_cache_file"
end

function __run_rake_completion
  test -f rakefile; or test -f Rakefile; or test -f rakefile.rb; or test -f Rakefile.rb
end

function __hashed_rakefiles
  for file in rakefile Rakefile rakefile.rb Rakefile.rb
    if test -e $file
      begin
        echo $PWD
        cat $file
        test -d lib; and cat lib/**/*.rake
      end | fish_md5
      return 0
    end
  end
  echo error
  return 1
end

complete -n __run_rake_completion \
  -x -c rake -a "(__cache_or_get_rake_completion)"
