function set_abbrs
    # git
    abbr -a -- g git
    abbr -a -- gb 'git branch'
    abbr -a -- gcm 'git checkout (git symbolic-ref --short refs/remotes/origin/HEAD | cut -d / -f 2)'
    abbr -a -- gco 'git checkout'
    abbr -a -- gdca 'git diff --cached'
    abbr -a -- gs 'git status -s  | cut -c4-'
    abbr -a -- gss 'git status -s'
    abbr -a -- vconflict 'vi (git conflict)'
    abbr -a -- vdirty 'vi ( git status -s | cut -c4- )'

    # dotfiles
    abbr -a -- d 'cd ~/Projects/dotfiles'
    abbr -a -- htree 'tree -a -I plugged\|\.git'
    abbr -a -- lsd 'ls -d .*'
    abbr -a -- p 'cd ~/Projects'
    abbr -a -- e 'cd ~/Projects/euler'

    abbr -a -- open xdg-open
end
