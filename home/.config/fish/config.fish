# Universal variables
set -U fish_user_paths \
    /opt/homebrew/bin \
    ~/.local/bin

# Global variables
set -gx SHELL (which fish)

if command -sq nvim
    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
    set -gx MANPAGER "nvim +Man!"
end

if test (uname) = Darwin
    set -gx XDG_CACHE_HOME ~/Library/Caches/xdg-cache
end

if command -sq brew
    set -gx HOMEBREW_BUNDLE_FILE ~/.config/brew/Brewfile
end

if command -sq fd
    set -gx FZF_DEFAULT_COMMAND 'fd -H --type file'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND 'fd -H --type directory'
end

if command -sq asdf
    set -gx ASDF_DATA_DIR ~/.local/opt/asdf
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
end
