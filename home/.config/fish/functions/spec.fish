function spec
    gss -- spec/**/*.rb | awk "{ print \$NF }" | xargs bundle exec rspec
end
