function rubo
    set command 'git status -s -- \*.{rb,rake} | cut -c4- | xargs bundle exec rubocop -a -D'

    echo $command
    eval $command
end
