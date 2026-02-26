# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/). This repo IS the chezmoi source directory (`~/.local/share/chezmoi/`).

## Machine classification

Two machine types: **personal** and **work**. Set once via `promptBoolOnce` in `.chezmoi.toml.tmpl` and stored in `~/.config/chezmoi/chezmoi.toml`.

- Personal: defaults hardcoded (no prompts beyond machine type)
- Work: prompts for email and GPG key

## Conventions

- **`dot_` prefix** → maps to `.` in home directory (e.g., `dot_zshrc` → `~/.zshrc`)
- **`.tmpl` suffix** → chezmoi template, rendered with data from `.chezmoi.toml.tmpl`
- **`private_` prefix** → chezmoi sets 0600 permissions on the target file
- **Plain files** (no `.tmpl`) → copied as-is

## Brewfiles

Split into three files under `dot_config/homebrew/`:

| File | Scope |
|---|---|
| `Brewfile` | Shared — installed on all machines |
| `Brewfile.personal` | Personal machine only |
| `Brewfile.work` | Work machine only |

`.chezmoiignore` excludes the wrong machine's Brewfile. The `run_onchange_` script concatenates shared + machine-specific and runs `brew bundle`.

## Templated files

Only `.gitconfig` is templated (email + GPG signing key vary by machine). Everything else is plain.

## Workflow

```sh
chezmoi diff          # preview changes
chezmoi apply -n -v   # dry-run
chezmoi apply         # apply for real
```

All changes go through PRs on `terrhorn/dotfiles`.
