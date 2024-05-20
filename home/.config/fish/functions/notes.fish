function notes
    set DAILY_DIR "$HOME/Projects/notes"
    set TODAYS_NOTES_FILE $DAILY_DIR/( date +%F ).md

    if not count $argv >/dev/null
        nvim -c 'set tw=72' $TODAYS_NOTES_FILE
    else
        if test $argv[1] = -m
            echo - ( date +%H:%M ) - $argv[2..-1] >>$TODAYS_NOTES_FILE
            return
        end

        set LAST_NOTES_FILE (echo $DAILY_DIR/*.md | awk '{ print $NF }')

        if test $argv[1] = review
            nvim -c 'set tw=72' -O $LAST_NOTES_FILE $TODAYS_NOTES_FILE
            return
        end

        if test $argv[1] = last
            nvim -c 'set tw=72' -O $LAST_NOTES_FILE
            return
        end

        echo 'No such argument for notes:' $argv[1]
        return 1
    end
end
