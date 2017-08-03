function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    if test $last_status -ne 0
      set prompt_last_status " [$last_status]"
    else
      set prompt_last_status
    end

    set -l cyan   (set_color cyan)
    set -l green  (set_color green)
    set -l red    (set_color red)
    set -l normal (set_color normal)

    echo -n -s "$cyan" (prompt_pwd) "$green" (__fish_vcs_prompt) "$red" "$prompt_last_status" "$normal" '> '
end
