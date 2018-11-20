function gbb
    __fish_is_git_repository
    or return

    set preview_command '
    git log \
      --oneline \
      --graph \
      --date=short \
      --color=always \
      --pretty="format:%C(auto)%cd %h%d %s" {-1} | head -$LINES '

    git branch --color=always |
    __fzf_down \
        +m \
        --expect='ctrl-v' \
        --nth -1 \
        --preview "$preview_command" |
    tail -n 1 |
    cut -c3- |
    read -l selected_branch

    commandline -r "git checkout $selected_branch"
end
