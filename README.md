# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply terrhorn/dotfiles
```

This installs chezmoi, clones the repo via HTTPS, prompts for machine type (personal/work), applies all dotfiles, and runs `brew bundle`.

Once SSH keys are set up, switch the remote to SSH for push access:

```sh
chezmoi cd
git remote set-url origin git@github.com:terrhorn/dotfiles.git
```

## Daily workflow

```sh
chezmoi update          # pull latest from GitHub and apply
chezmoi diff            # preview pending changes
chezmoi apply           # apply changes from source dir
brew-cleanup            # list and remove packages not in Brewfiles
```

## Editing dotfiles

Edit files in the source directory (`~/code/dotfiles` or `~/terrhorn/dotfiles`), then commit and PR as usual. Run `chezmoi apply` to apply locally.
