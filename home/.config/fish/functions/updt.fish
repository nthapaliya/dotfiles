function updt
    set brew_cache_dir ~/Library/Caches/Homebrew

    test -d $brew_cache_dir; or mkdir -p $brew_cache_dir

    set hfile $brew_cache_dir/.updated

    if test -f $hfile
        set time_diff (math (date +%s) - (date -r $hfile +%s))
        test "$time_diff" -lt 14400; and return 1
    end

    touch $hfile

    set commands \
        'brew update' \
        'brew upgrade' \
        'brew cask outdated' \
        'curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy >~/.local/bin/diff-so-fancy' \
        'brew bundle dump --force --file=~/.config/brew/Brewfile'

    for command in $commands
        echo $command
        eval $command
    end
end
