function notes
    set DAILY_DIR "$HOME/Projects/notes"
    set todays_notes_file $DAILY_DIR/( date +%F ).md

    if not count $argv >/dev/null
        nvim -c 'set tw=72' $todays_notes_file
    else
        if test $argv[1] = -m
            echo - ( date +%H:%M ) - $argv[2..-1] >>$todays_notes_file
            return
        end

        if test $argv[1] = review
            nvim -c 'set tw=72' -O (echo $DAILY_DIR/*.md | awk '{ print $NF }') $todays_notes_file
            return
        end

        nvim -c 'set tw=72' $DAILY_DIR/( gdate +%F -d "$argv" ).md
    end
end
