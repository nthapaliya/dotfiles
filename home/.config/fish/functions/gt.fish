function gt
    __fish_is_git_repository
    or return

    git tag \
        --sort -taggerdate |
    __fzf_down \
        --preview 'git show --color=always {} | diff-so-fancy | head -$LINES'
end
