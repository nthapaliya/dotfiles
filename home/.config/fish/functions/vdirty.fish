function vdirty
    set -l dirty_files
    set -l git_args
    set -l interactive

    for option in $argv
        switch "$option"
            case -i --interactive
                set interactive true
            case \*
                set git_args $git_args $option
        end

    end

    if test -n "$interactive"
        set -l preview_command '
        function __diff_or_cat
          if git ls-files --error-unmatch $argv >/dev/null 2>/dev/null
            git diff --color $argv | diff-so-fancy
          else
            set_color green; echo +++ NEW FILE +++ ; set_color normal; echo;
            bat --color always --paging never $argv
          end
        end
        __diff_or_cat {}'
        set dirty_files ( git status -s $git_args | awk '{ print $NF }' | fzf -m --reverse --preview="$preview_command")
    else
        set dirty_files ( git status -s $git_args | awk '{ print $NF }' )
    end

    if test -n "$dirty_files"
        eval $EDITOR $dirty_files
    else
        echo 'Nothing to edit!'
    end
end
