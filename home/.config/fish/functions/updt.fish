function updt
    if test (uname) != Darwin
        return 1
    end

    set brew_cache_dir ~/Library/Caches/Homebrew
    set hfile $brew_cache_dir/.updated

    test -d $brew_cache_dir; or mkdir -p $brew_cache_dir
    test -f $hfile; or touch $hfile

    test (math (date +%s) - (date -r $hfile +%s)) -lt (math 8 \* 60 \* 60); and return 1

    touch $hfile

    echo 'Running curl commands...'
    curl --silent -L https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >~/.config/nvim/autoload/plug.vim
    curl --silent -L https://raw.githubusercontent.com/franciscolourenco/done/master/conf.d/done.fish >~/.config/fish/conf.d/done.fish

    # Run this manually
    # __update_dsf

    echo 'Running brew commands...'
    brew bundle dump --force --describe --file=~/.config/brew/Brewfile
    brew update
    brew upgrade
    brew outdated --cask
end

function __update_dsf
    brew install cpanminus
    cpanm App::FatPacker
    echo '#!/bin/bash'\n \
        'fatpack_bin=$(find /usr/local/Cellar/perl -name fatpack | tail -1)'\n \
        '$fatpack_bin "$@"' >~/.local/bin/fatpack
    chmod +x ~/.local/bin/fatpack

    git -C ~/Projects clone https://github.com/so-fancy/diff-so-fancy.git
    git -C ~/Projects/diff-so-fancy up
    ~/Projects/diff-so-fancy/third_party/build_fatpack/build.pl --output ~/Projects/dotfiles/home/.local/bin/diff-so-fancy
end
