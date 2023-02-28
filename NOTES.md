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
    hyperfine \
    ripgrep \
    stylua \
    topgrade \
    vim-profiler
```
### In case you can't install rust and cargo:

Install fd, rg and delta via asdf

```
asdf plugin add delta https://github.com/andweeb/asdf-delta.git
asdf install delta latest
asdf global delta latest  # Set a version globally (on your ~/.tool-versions file)

asdf plugin add fd https://gitlab.com/wt0f/asdf-fd
asdf install fd latest
asdf global fd latest

asdf plugin add ripgrep https://gitlab.com/wt0f/asdf-ripgrep
asdf install ripgrep latest
asdf global ripgrep latest
```

THIS IS OUTDATED^^, use the script `install_asdf.fish` instead

### Setting up fish:

Assuming running bash:

```bash
# add $(which fish) to `/etc/shells` if it doesn't exist
$ cat /etc/shells # to check if fish is already listed
$ echo $(which fish) | sudo tee -a /etc/shells
$ sudo chsh -s $(which fish) $(whoami)
$ sudo reboot now # not sure if really needed
```


### Dependencies

Asdf ruby:
```bash
sudo apt-get install autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev pkg-config uuid-dev
```
