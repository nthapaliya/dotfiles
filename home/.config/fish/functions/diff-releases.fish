function diff-releases
    if test -n $argv[1]
        set server $argv[1]
    else
        set server qa
    end

    set rev_list (ssh $server.ossd.co 'cat /srv/www/huddle/releases/*/LATEST_GIT_HEAD | cut -d " " -f 1 | xargs | sed "s/ /../"')

    set commits (git rev-list --ancestry-path --merges $rev_list)

    git closest-pr $commits
end
