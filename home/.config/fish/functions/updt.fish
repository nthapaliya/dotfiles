function updt
    if test (uname) != 'Darwin'
        return 1
    end

    set brew_cache_dir ~/Library/Caches/Homebrew
    set hfile $brew_cache_dir/.updated

    test -d $brew_cache_dir; or mkdir -p $brew_cache_dir
    test -f $hfile; or touch $hfile

    test (math (date +%s) - (date -r $hfile +%s)) -lt (math 8 \* 60 \* 60); and return 1

    touch $hfile

    echo 'Running curl commands...'
    curl --silent -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy >~/.local/bin/diff-so-fancy
    curl --silent -L https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >~/.config/nvim/autoload/plug.vim
    curl --silent -L https://raw.githubusercontent.com/fishpkg/fish-humanize-duration/master/humanize_duration.fish >~/.config/fish/conf.d/humanize_duration.fish
    curl --silent -L https://raw.githubusercontent.com/franciscolourenco/done/master/conf.d/done.fish >~/.config/fish/conf.d/done.fish

    echo 'Running brew commands...'
    brew bundle dump --force --describe --file=~/.config/brew/Brewfile
    brew update
    brew upgrade
    brew outdated --cask
end
