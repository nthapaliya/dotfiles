function hist_query
    sqlite3 -readonly ~/.local/share/polygon/history.sqlite $argv
end
