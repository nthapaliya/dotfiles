function gls
    __fish_is_git_repository
    or return

    git ls-files |
    __fzf_down \
        --preview 'bat --color always --paging never {} | head -$LINES'
end
