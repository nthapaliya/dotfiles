# TODO: I want this to be shorter, like `r`
function cdr
    __fish_is_git_repository
    or return

    cd (git rev-parse --show-toplevel)
end
