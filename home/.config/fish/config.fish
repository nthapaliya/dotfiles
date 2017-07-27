# Basic path config
set -gx PATH $PATH ~/.local/bin ~/Lang/rbenv/bin

# Set $EDITOR
set -gx EDITOR nvim

# set $SHELL
set -gx SHELL /usr/local/bin/fish

# Rbenv

set -gx RBENV_ROOT ~/Lang/rbenv
status --is-interactive; and source (rbenv init -|psub)

# general
alias al='rg --files-with-matches --smart-case'
alias vi='nvim'

# work
abbr --add mqa 'env HOST=qa.ossd.co BRANCH=(gcb) bundle exec mina full_deploy '

alias rubo='git diff --name-only -z -- \*.{rb,rake} | xargs -0 bundle exec rubocop -a -R -D'
alias rubox='bundle exec rubocop -a -R -D **/*.{rb,rake}'

abbr --add hud 'cd ~/OSS/huddle'
abbr --add vd "cd ~/OSS/huddle/app/assets/javascripts/visual_directory"
abbr --add vdc "cd ~/OSS/huddle/app/assets/javascripts/visual_directory/components"

alias spec='gss -- spec/**/*.rb | awk "{ print \$NF }" | xargs bundle exec rspec'

alias graylog='ssh -N -L 12900:localhost:12900 -L 9000:localhost:9000 root@kraken.officespacesoftware.com'
alias forward_local='ssh -N -tt osadmin@builder.ossd.co -R 10000:localhost:3000'

alias reyarn='git_root; rm -rf node_modules; yarn install;'

# git
abbr --add g 'git'
abbr --add gb 'git branch'
abbr --add gcm 'git checkout master'
abbr --add gcmt 'git commit'
abbr --add gco 'git checkout'
abbr --add gdca 'git diff --cached'
abbr --add gss 'git status -s'

alias gcb='git rev-parse --abbrev-ref HEAD'
alias git_root='cd ( git rev-parse --show-toplevel )'
alias conflict='git status -s | grep UU | cut -d " " -f 2 '
alias vdirty='eval $EDITOR ( git status -s | awk "{ print \$NF }" ) '
alias gdev='git_root; git apply ../dev.patch'

# misc
alias now='date +"%R"'
alias today='eval $EDITOR $HOME/OSS/notes/daily/( gdate +%F ).md'

# dotfiles
abbr --add lsd 'ls -d .*'
abbr --add htree 'tree -a -I plugged\|\.git'
alias edit_config='eval $EDITOR ~/.config/fish/config.fish '
alias reload_config='source ~/.config/fish/config.fish'
