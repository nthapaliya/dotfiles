function set_abbrs
    abbr --list | while read abbreviation
        abbr -e $abbreviation
    end

    # Work stuff
    abbr -a -- mqa 'ssh-add -k ; env HOST=qa.ossd.co BRANCH=(gcb) bin/mina full_deploy;'
    abbr -a -- rsqa 'rsync -azvh osadmin@qa.ossd.co:/srv/www/huddle/shared/floors/ ~/OSS/huddle/floors'
    abbr -a -- h 'cd ~/OSS/huddle'

    # git
    abbr -a -- g 'git'
    abbr -a -- gb 'git branch'
    abbr -a -- gcm 'git checkout master'
    abbr -a -- gco 'git checkout'
    abbr -a -- gdca 'git diff --cached'
    abbr -a -- gss 'git status -s'

    # dotfiles
    abbr -a -- d 'cd ~/Projects/dotfiles'
    abbr -a -- htree 'tree -a -I plugged\|\.git'
    abbr -a -- lsd 'ls -d .*'
    abbr -a -- p 'cd ~/Projects'
end
