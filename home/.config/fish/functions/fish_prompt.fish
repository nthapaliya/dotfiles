function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    if not set -q __fish_git_prompt_char_dirtystate
        set -g __fish_git_prompt_char_dirtystate '*'
    end

    if not set -q __fish_git_prompt_showdirtystate
        set -g __fish_git_prompt_showdirtystate 'yes'
    end

    if not set -q __fish_git_prompt_showcolorhints
        set -g __fish_git_prompt_showcolorhints 'yes'
    end

    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch green --bold
    end

    set_color cyan
    printf '%s' (prompt_pwd)
    set_color normal

    printf '%s' (__fish_vcs_prompt)

    if test $last_status -ne 0
        set_color red
        echo -n "[$last_status]"
    end

    set_color normal
    echo -n '> '
end
