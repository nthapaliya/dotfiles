function hist_query
	sqlite3 "file:$HOME/.local/share/history.sqlite?mode=ro" $argv
end
