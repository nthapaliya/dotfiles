set -g __fish_git_prompt_describe_style 'branch'
set -g __fish_git_prompt_shorten_branch_len 15
set -g __fish_git_prompt_showcolorhints 'yes'
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'yes'

set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_char_untrackedfiles '*'

function fish_prompt --description 'Write out the prompt'
    set last_status $status

    # Once fish is updated, you can delete this line
    # And make stuff in conf.d respond to regular postexec
    emit custom_postexec $last_status $CMD_DURATION

    if set -q SSH_CLIENT
        or set -q SSH_TTY
        printf '%s%s@%s ' (set_color yellow) (whoami) (prompt_hostname)
    end

    # TODO: remove double underscore from __fish_git_prompt
    # when Raspbian has fish version greater than v3.1.2
    printf '%s%s%s%s' (set_color cyan) (prompt_pwd) (set_color normal) (__fish_git_prompt)

    if test $last_status -ne 0
        printf '%s[%s]' (set_color red) $last_status
    end

    printf '%s> ' (set_color normal)
end
