function edit --description 'edit fish functions and bash scripts in $PATH'
    e ( type --force-path $argv[1] 2>/dev/null || functions --details $argv[1] | grep -v 'n/a' )
end
