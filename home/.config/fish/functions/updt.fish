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
        # 'brew cleanup' \
        'brew cask outdated' \
        'brew bundle dump --force --file=~/.config/brew/Brewfile' \
        # 'brew cask upgrade' \
        'mas outdated' \
        # 'mas upgrade'
        'nvim +PlugUpgrade +PlugUpdate'

    for command in $commands
        echo $command
        eval $command
    end
end
