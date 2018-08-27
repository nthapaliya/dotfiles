function notes
    set -l DAILY_DIR "$HOME/OSS/notes/daily2"
    if not count $argv >/dev/null
        nvim -c 'set tw=72' $DAILY_DIR/( gdate +%F ).md
    else
        if test $argv[1] = '-m'
            echo - ( gdate +%H:%M ) - $argv[2..-1] >>$DAILY_DIR/( gdate +%F ).md
            return
        end

        nvim -c 'set tw=72' $DAILY_DIR/( gdate +%F -d "$argv" ).md
    end
end
