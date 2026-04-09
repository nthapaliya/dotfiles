# Installing basic dependencies

| Package Name        | Version |
| ---                 | ---     |
| stow                | any     |
| neovim              | latest  |
| fish                | latest  |
| tmux                | latest  |
| git                 | latest  |
| vim                 | any     |
| bat                 | any     |
| git-delta           | any     |
| fd-find             | any     |
| fzf                 | any     |
| jq                  | any     |
| ripgrep             | any     |
| tree-sitter         | latest  |
| lua-language-server | any     |
| stylua              | any     |
| uv                  | any     |

Try to rely on system package managers first (brew, apt, dnf)

```bash
sudo dnf install stow fish git tmux neovim
sudo dnf install bat git-delta fd-find fzf jq ripgrep tree-sitter
```

If these aren't available or are too old, use mise

# Installing mise

Use your package manager or [install it manually](https://mise.jdx.dev/installing-mise.html):

```bash
curl https://mise.run > setup-mise.sh
chmod +x setup-mise.sh
./setup-mise.sh
```

Then install missing tools with:

```bash
mise use --global <tools>
```

See what's installed via mise with:

```bash
mise list
```

Useful settings
```bash
mise settings install_before="14d"
mise settings python.uv_venv_auto="source"
```

Finally, uncomment mise related configs in fish shell config

I'm not committing the mise configs because they will be different
on each machine.

# Alternative to mise

## Example: installing `nvim` directly from Github

Assuming ~/.local/bin is already in `$PATH`

- Go to their [Github releases
  page](https://github.com/neovim/neovim/releases/tag/v0.12.1) and see if they
have prebuilt binaries.
- Copy link for your system.

```bash
mkdir -p ~/.local/packages/
cd ~/.local/packages/
wget https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
stow nvim-linux-x86_64
```

Now `which nvim` should now point to `~/.local/bin/nvim`

> [!NOTE]
>
> `stow packageName` will symlink its contents to `../` by default, so make
> sure the directory structure is `~/.local/packages/packageName` where
> `packageName/` contains `bin/` (and other things).
>
> Then from `.local/packages` run `stow packageName`

To update:
```bash
cd ~/.local/packages
stow -D packageName
rm -rf packageName
```

Then follow the steps to install, from the beginning.

# Link and unlink dotfiles

```bash
./install    # To link
./install -u # To unlink
```

# Self-notes and references

- If in a minimal system, a decent vimrc has been provided for quick
  and dirty edits. Copy it from project root to $HOME/.vimrc.

- There is a list of tools in the install script that are "required" by these
  configs (they're assumed to exist in various scripts and don't guard against
  them not existing).

  Make sure those tools are installed.

- Add `fish` to `/etc/shells` and make a login shell:

  Assuming currently in bash:

  ```bash
  cat /etc/shells # to check if fish is already listed
  echo $(which fish) | sudo tee -a /etc/shells
  sudo chsh -s $(which fish) $(whoami)
  # sudo reboot now # optional
  ```

# For later
- https://github.com/mhinz/vim-galore
  - also ref: https://github.com/mhinz/vim-galore/blob/master/static/minimal-vimrc.vim
- https://piechowski.io/post/git-commands-before-reading-code/
