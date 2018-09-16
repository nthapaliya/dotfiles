if not set -q __fish_git_prompt_char_dirtystate
    set -g __fish_git_prompt_char_dirtystate '*'
end

if not set -q __fish_git_prompt_showdirtystate
    set -g __fish_git_prompt_showdirtystate 'yes'
end

if not set -q __fish_git_prompt_showcolorhints
    set -g __fish_git_prompt_showcolorhints 'no'
end

if not set -q __fish_git_prompt_color_branch
    set -g __fish_git_prompt_color_branch green --bold
end

if not set -q __fish_git_prompt_shorten_branch_len
    set -g __fish_git_prompt_shorten_branch_len 15
end

function fish_prompt --description 'Write out the prompt'
    set last_status $status
    emit custom_postexec $status $cmd_duration

    if set -q SSH_CLIENT
        or set -q SSH_TTY
        printf '%s%s@%s ' (set_color yellow) (whoami) (prompt_hostname)
    end

    printf '%s%s%s%s' (set_color cyan) (prompt_pwd) (set_color normal) (__fish_vcs_prompt)

    if test $last_status -ne 0
        printf '%s[%s]' (set_color red) $last_status
    end

    printf '%s> ' (set_color normal)
end
