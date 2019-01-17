function r
    __fish_is_git_repository
    or return

    cd (git rev-parse --show-toplevel)
end
