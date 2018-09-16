function spec
    set command 'git status -s -- spec/**/*_spec.rb | cut -c4- | xargs bundle exec rspec'

    echo $command
    eval $command
end
