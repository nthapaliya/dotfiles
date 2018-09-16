function gh
    __fish_is_git_repository
    or return

    set preview_command '
      echo {} |\
      sed -nEe "s/.+ ([a-f0-9]{7,}) .+/\1/p" |\
      xargs git show --color=always | diff-so-fancy | head -$LINES
    '

    git log \
        --color=always \
        --date=short \
        --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" \
        --graph \
        $argv |
    __fzf_down \
        --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --no-sort \
        --preview "$preview_command" |
    sed -nEe "s/.+ ([a-f0-9]{7,}) .+/\1/p"
end
