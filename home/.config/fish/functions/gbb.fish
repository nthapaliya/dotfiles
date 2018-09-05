function gbb
    __fish_is_git_repository
    or return

    set -l preview_command '
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
    read -l --all-lines --array output
    set -l selected_branch ( echo $output[2] | cut -c3- )

    if test "$output[1]" = 'ctrl-v'
        echo $selected_branch
        return
    end

    commandline -r "git checkout $selected_branch"
end
