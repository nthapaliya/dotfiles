# Notes

## TODOS:
- [ ] look into conventional commits: https://www.conventionalcommits.org/en/v1.0.0/#summary
- [x] try neoorg, orgmode: https://github.com/nvim-orgmode/orgmode
- [x] fix gx to open urls

## NOTES:
### asdf:
Install asdf dependencies:
https://asdf-vm.com/guide/getting-started.html

Then:

```fish
# This is needed to set up $ASDF_DIR
set_up_fish
git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.11.1
# reload fish
for PLUGIN in (cut -d ' ' -f1 ~/.tool-versions)
    eval asdf plugin add $PLUGIN
end
asdf install
set_up_fish
asdf reshim
```
After that:

```fish
cargo install \
    bat \
    cargo-check \
    cargo-outdated \
    cargo-update \
    fd-find \
    git-delta \
    ripgrep \
    stylua \
    topgrade \
    vim-profiler
```
