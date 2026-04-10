# Essentials:
# fish_config theme choose coolbeans
fish_add_path ~/.local/bin
set -U fish_greeting
set -gx SHELL fish

## nvim
set -gx EDITOR (which nvim)
set -gx VISUAL $EDITOR
set -gx MANPAGER "nvim +Man!"

# abbrs:
## git
abbr -a -- g git
abbr -a -- gb 'git branch'
abbr -a -- gcm 'git checkout (git symbolic-ref --short refs/remotes/origin/HEAD | cut -d / -f 2)'
abbr -a -- gco 'git checkout'
abbr -a -- gdca 'git diff --cached'
abbr -a -- gs 'git status -s  | cut -c4-'
abbr -a -- gss 'git status -s'
abbr -a -- vconflict 'vi (git conflict)'
abbr -a -- vdirty 'vi ( git status -s | cut -c4- )'

## dotfiles
abbr -a -- d 'cd ~/Projects/dotfiles'
abbr -a -- htree 'tree -a -I .git'
abbr -a -- lsd 'ls -d .*'
abbr -a -- p 'cd ~/Projects'
abbr -a -- e 'cd ~/Projects/euler'

# Command specific:

## [fzf, rg, fd, bat, tmux]: assume available
set -gx RIPGREP_CONFIG_PATH ~/.config/rg/config
set -gx FZF_DEFAULT_COMMAND 'fd -H --type f'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_CTRL_T_OPTS "
        --tmux 90%,50% \
        --preview 'bat -n --color=always {}' \
        --bind 'ctrl-/:change-preview-window(down|hidden|)' "
fzf --fish | source

# OS Specific
if test Darwin = (uname)
    fish_add_path -a /opt/homebrew/bin

    set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache
    set -gx HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
end
