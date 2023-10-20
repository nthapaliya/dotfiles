#/usr/bin/env fish
# vim: set ft=fish:

./install
set -Ux ASDF_DIR ~/.local/opt/asdf
set -Ux ASDF_DATA_DIR ~/.local/opt/asdf_installs
git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.13.1
fish_add_path $ASDF_DIR/bin
for PLUGIN in (cut -d ' ' -f1 ~/.tool-versions)
    eval asdf plugin add $PLUGIN
end
asdf install

fish_add_path $ASDF_DATA_DIR/shims
asdf reshim
cargo install \
    bat \
    cargo-check \
    cargo-outdated \
    cargo-update \
    fd-find \
    git-delta \
    hyperfine \
    ripgrep \
    stylua \
    topgrade \
    vim-profiler

asdf reshim
# to set up fzf default commands with fd and rg
set_up_fish
