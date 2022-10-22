function updt
    __checktime; or return 1

    __updt_os_agnostic

    if test (uname) = Darwin
        echo 'Running brew commands...'
        brew bundle dump --force --describe --file=~/.config/brew/Brewfile
        brew update
        brew upgrade
    else if test (uname) = Linux
        echo "Updating and upgrading apt"
        echo "sudo apt update && sudo apt upgrade"
        sudo apt update && sudo apt upgrade
    end
end

function __checktime
    set hfile ~/.local/share/updt/last_updated
    test -d (dirname $hfile); or mkdir -p (dirname $hfile)

    if not test -f $hfile
        touch $hfile
        return 0
    end

    test (math (date +%s) - (date -r $hfile +%s)) -lt (math 8 \* 60 \* 60); and return 1

    touch $hfile
    return 0
end

function __updt_os_agnostic
    if not set -q SSH_CLIENT
        echo 'Updating `done.fish`'
        cd ~/Projects/dotfiles/home/.config/fish/conf.d/
        curl --silent -L --remote-name \
            https://raw.githubusercontent.com/franciscolourenco/done/master/conf.d/done.fish
        cd ~/Projects/dotfiles/home/.vim/autoload/
        echo 'Updating `plug.vim`'
        curl --silent -L --remote-name \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        cd -
    end

    if command -sq nvim
        echo 'Updating neovim plugins'
        nvim --headless -c 'autocmd User PackerComplete quitall' -c PackerSync
    end
    if command -sq vim
        echo 'Updating vim plugins'
        vim +PlugUpdate +qall
    end
end
