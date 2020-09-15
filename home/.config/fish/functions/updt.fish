function updt
    if test (uname) != 'Darwin'
        return 1
    end

    set brew_cache_dir ~/Library/Caches/Homebrew

    test -d $brew_cache_dir; or mkdir -p $brew_cache_dir

    set hfile $brew_cache_dir/.updated

    if test -f $hfile
        set time_diff (math (date +%s) - (date -r $hfile +%s))
        test "$time_diff" -lt (math 8 \* 60 \* 60); and return 1
    end

    touch $hfile

    set commands \
        'curl --silent -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy >~/.local/bin/diff-so-fancy &' \
        'curl --silent -L https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >~/.config/nvim/autoload/plug.vim &' \
        'brew bundle dump --force --describe --file=~/.config/brew/Brewfile &' \
        'brew update' \
        'brew upgrade' \
        'brew outdated --cask'

    for command in $commands
        echo $command
        eval $command
    end
end
