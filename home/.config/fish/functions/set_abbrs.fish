function set_abbrs
    abbr --list | while read abbreviation
        abbr -e $abbreviation
    end

    # Work stuff
    abbr -a -- mqa 'ssh-add -k ; env HOST=qa.ossd.co BRANCH=(git branch --show-current) bin/mina full_deploy;'
    abbr -a -- rsqa 'rsync -azvh osadmin@qa.ossd.co:/srv/www/huddle/shared/floors/ ~/OSS/huddle/floors'
    abbr -a -- h 'cd ~/OSS/huddle'
    abbr -a -- q 'cd ~/OSS/qa'
    abbr -a -- ofe 'open http://localhost:3000/manager/editor'
    abbr -a -- oma 'open http://localhost:3000/manager'
    abbr -a -- ovd 'open http://localhost:3000/visual_directory'
    abbr -a -- rubox 'bin/rubocop -a -D **/*.{rb,rake}'
    abbr -a -- rubo 'git status -s -- \*.{rb,rake} | cut -c4- | xargs bin/rubocop -a -D'
    abbr -a -- spec 'git status -s -- spec/**/*_spec.rb | cut -c4- | xargs bin/rspec'
    abbr -a -- vconflict 'nvim (git conflict)'
    abbr -a -- vdirty 'nvim ( git status -s | cut -c4- )'

    # git
    abbr -a -- g 'git'
    abbr -a -- gb 'git branch'
    abbr -a -- gcm 'git checkout master'
    abbr -a -- gco 'git checkout'
    abbr -a -- gdca 'git diff --cached'
    abbr -a -- gss 'git status -s'
    abbr -a -- gs 'git status -s  | cut -c4-'

    # dotfiles
    abbr -a -- d 'cd ~/Projects/dotfiles'
    abbr -a -- htree 'tree -a -I plugged\|\.git'
    abbr -a -- lsd 'ls -d .*'
    abbr -a -- p 'cd ~/Projects'
end
