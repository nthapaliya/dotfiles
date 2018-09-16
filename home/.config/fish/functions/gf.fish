function gf
    set preview_command '
      if git ls-files --error-unmatch {-1} >/dev/null 2>/dev/null
        git diff --color {-1} | diff-so-fancy | head -$LINES
      else
        set_color green; echo +++ NEW FILE +++ ; set_color normal; echo;
        bat --color always --paging never {-1} | head -$LINES
      end;'

    set output
    git -c color.status=always status --short -- $argv |
    __fzf_down \
        --bind='ctrl-e:execute( nvim {+-1} > /dev/tty )' \
        --expect='alt-p,alt-r' \
        --nth 2..,.. \
        --preview="$preview_command" |
    while read --line outputline
        set -a output $outputline
    end

    set selected_files ( string join \n $output[2..-1] | cut -c4- )

    test -z "$selected_files"
    and return

    if test $output[1] = 'alt-p'
        echo "ADDING"
        git add -p $selected_files
        return
    end

    if test $output[1] = 'alt-r'
        echo "REVERTING"
        git checkout -p $selected_files
        return
    end

    string join \n $selected_files
end

# TODO:
# - add function description
# - command line substitution (by default?)
# - git add -p support
# - edit in vim
# - Add header with hints about ctrl-e, and alt-p alt-r options
# - this is already used by another function, by default
# don't mess with its output
# see ./cdf.fish for merging of git ls-files and rg --files
# see ./gbb.fish for usage of 'read' and handling 'expect' types
