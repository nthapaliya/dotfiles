function nvm-use
    set node_versions_path $NVM_DIR/versions/node
    set target_version $argv[1]

    set clean_path (string match -ev "$node_versions_path" $PATH)
    set clean_fish_user_paths (string match -ev "$node_versions_path" $fish_user_paths)

    if test "$target_version" = 'system'
        # set -gx PATH $clean_path
        set -U fish_user_paths $clean_fish_user_paths
        return 0
    end

    if test -z "$target_version"
        if test -f .nvmrc
            set target_version (cat .nvmrc)
        else
            echo "Error: No version provided and no .nvmrc found"
            return 1
        end
    end

    set matched_version (bash -c "source $NVM_DIR/nvm.sh --no-use; nvm_version $target_version")

    if test -z "$matched_version" -o "$matched_version" = 'N/A'
        echo "No version installed for $target_version, run nvm install $target_version"
        echo "Installed versions: "
        for file in $node_versions_path/v*
            echo ' -' $file
        end
        return 1
    end

    # set -gx PATH $node_versions_path/$matched_version/bin $clean_path
    set -U fish_user_paths $node_versions_path/$matched_version/bin $clean_fish_user_paths
end

function nvm
    set -q NVM_DIR
    or set -g NVM_DIR ~/.nvm

    if test (count $argv[1]) -lt 1
        echo 'nvm-fast: at least one argument is required'
    end

    if test $argv[1] = 'use'
        nvm-use $argv[2..-1]
    else
        bash -c "source $NVM_DIR/nvm.sh --no-use; nvm $argv"
    end
end
