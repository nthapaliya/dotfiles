function notes
    if not count $argv >/dev/null
        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F ).md
    else
        if test $argv[1] = '-m'
            echo - ( gdate +%H:%M ) - $argv[2..-1] >>$HOME/OSS/notes/daily/( gdate +%F ).md
            return
        end

        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F -d "$argv" ).md
    end
end
