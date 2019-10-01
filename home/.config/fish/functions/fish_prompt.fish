set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showcolorhints 'no'
set -g __fish_git_prompt_color_branch green --bold
set -g __fish_git_prompt_shorten_branch_len 15

function fish_prompt --description 'Write out the prompt'
    set last_status $status
    emit custom_postexec $status $CMD_DURATION

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
