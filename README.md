# Install and uninstall

```bash
./install
```

```bash
./install -u
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
