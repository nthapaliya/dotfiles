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

    echo 'Updating neovim plugins'
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
    echo

    # Run this manually
    # __update_from_github

    echo 'Running brew commands...'
    brew bundle dump --force --describe --file=~/.config/brew/Brewfile
    brew update
    brew upgrade
end

function __update_from_github
    set -l dotfiles ~/Projects/dotfiles/home
    set -l done_stuff \
        https://raw.githubusercontent.com/franciscolourenco/done/master/conf.d/done.fish \
        $dotfiles/.config/fish/conf.d/done.fish
    curl --silent -L $done_stuff[1] >$done_stuff[2]

    set -l dsf_url (curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest | jq -r .assets[0].browser_download_url)
    set -l dsf_file $dotfiles/.local/bin/diff-so-fancy
    curl -L $dsf_url >$dsf_file && chmod +x $dsf_file
end
