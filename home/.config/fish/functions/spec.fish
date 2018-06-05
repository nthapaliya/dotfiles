function spec
	git status -s -- spec/**/*_spec.rb | awk "{ print \$NF }" | xargs bundle exec rspec
end
