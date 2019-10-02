function gbb
    __fish_is_git_repository
    or return

    set branch ( git branch --color=always |
                 fzf --height '40%' --reverse --ansi |
                 awk '{ print $NF }' )

    test -n "$branch" && git checkout "$branch"
end
