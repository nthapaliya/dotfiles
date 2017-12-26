# Defined in /var/folders/gs/v5r7z1994l15d9ftgjdvgvmm0000gn/T//fish.GskaIv/notes.fish @ line 1
function notes
	if not set -q $argv
    eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F ).md
  else
    eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F -d "$argv" ).md
  end
end
