function rubo
    git diff --name-only -z -- \*.{rb,rake} | xargs -0 bundle exec rubocop -a -R -D
end
