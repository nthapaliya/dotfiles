# Notes

## TODOS:
- [ ] look into conventional commits: https://www.conventionalcommits.org/en/v1.0.0/#summary
- [x] try neoorg, orgmode: https://github.com/nvim-orgmode/orgmode
- [x] fix gx to open urls

## NOTES:
### Setting up fish:

Assuming running bash:

```bash
# add $(which fish) to `/etc/shells` if it doesn't exist
$ cat /etc/shells # to check if fish is already listed
$ echo $(which fish) | sudo tee -a /etc/shells
$ sudo chsh -s $(which fish) $(whoami)
$ sudo reboot now # not sure if really needed
```
