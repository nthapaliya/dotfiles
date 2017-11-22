function vcommit
	if count $argv > /dev/null
    eval $EDITOR (git diff-tree --no-commit-id --name-only -r $argv)
  else
    eval $EDITOR (git diff-tree --no-commit-id --name-only -r HEAD)
  end
end
