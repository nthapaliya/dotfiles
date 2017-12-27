function spec
    git status -s -- spec/**/*.rb | awk "{ print \$NF }" | xargs bundle exec rspec
end
