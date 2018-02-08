function notes
    if not count $argv >/dev/null
        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F ).md
    else
        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F -d "$argv" ).md
    end
end
