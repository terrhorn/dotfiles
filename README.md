# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply terrhorn/dotfiles --ssh
```

This installs chezmoi, clones the repo, prompts for machine type (personal/work), applies all dotfiles, and runs `brew bundle`.

## Daily workflow

```sh
chezmoi update          # pull latest from GitHub and apply
chezmoi diff            # preview pending changes
chezmoi apply           # apply changes from source dir
brew-cleanup            # list and remove packages not in Brewfiles
```

## Editing dotfiles

Edit files in the source directory (`~/code/dotfiles` or `~/terrhorn/dotfiles`), then commit and PR as usual. Run `chezmoi apply` to apply locally.
