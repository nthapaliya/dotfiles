# Defined in /var/folders/gs/v5r7z1994l15d9ftgjdvgvmm0000gn/T//fish.3FDjY7/tmcc.fish @ line 1
function tmcc
	tmux -f /dev/null -CC attach $argv
  or tmux -f /dev/null -CC new $argv
end
