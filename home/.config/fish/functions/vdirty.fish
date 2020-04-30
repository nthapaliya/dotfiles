function __gf
    set preview_command '
          if git ls-files --error-unmatch {-1} >/dev/null 2>/dev/null
            git diff --color {-1} | diff-so-fancy | head -$LINES
          else
            set_color green; echo +++ NEW FILE +++ ; set_color normal; echo;
            bat --color always --paging never {-1} | head -$LINES
          end;'

    git -c color.status=always status --short -- $argv |
    fzf --ansi --exit-0 --multi --preview-window=down:80% --reverse \
        --nth 2..,.. \
        --preview="$preview_command"
end

function vdirty
    argparse 'i/interactive' -- $argv

    set git_args $argv

    if test -n "$_flag_interactive"
        nvim ( __gf )
    else
        nvim ( git status -s -- $git_args | cut -c4- )
    end
end
