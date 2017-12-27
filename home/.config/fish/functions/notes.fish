function notes
    if not set -q $argv
        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F ).md
    else
        eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F -d "$argv" ).md
    end
end
