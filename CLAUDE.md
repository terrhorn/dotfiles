# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/). This repo IS the chezmoi source directory (`~/.local/share/chezmoi/`).

## Machine classification

Two machine types: **personal** and **work**. Set once via `promptBoolOnce` in `.chezmoi.toml.tmpl` and stored in `~/.config/chezmoi/chezmoi.toml`.

- Personal: defaults hardcoded (no prompts beyond machine type)
- Work: prompts for email

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

| File | What varies |
|---|---|
| `dot_gitconfig.tmpl` | Email (per machine type) |
| `dot_config/gh/config.yml.tmpl` | Slack extension (work only) |
| `private_dot_ssh/allowed_signers.tmpl` | Email + signing key (read from local filesystem at apply time via `output`) |

## Commit signing

All machines use **SSH signing** (not GPG). Each machine needs `~/.ssh/id_ed25519_signing` — the `.gitconfig` and `allowed_signers` files reference this key. GPG was removed intentionally; don't re-introduce it.

## What this repo does NOT manage

- **`~/.claude/settings.json`** — owned by `~/.agents`, not chezmoi. The agents repo manages Claude Code configuration to keep it portable across tools.
- **Auth state** (gh `hosts.yml`, 1Password, etc.) — per-machine, excluded via `.chezmoiignore`
- **Runtime caches** (`.npm/`, `.cargo/`, `.bun/`, etc.)

## Workflow

```sh
chezmoi diff          # preview changes
chezmoi apply -n -v   # dry-run
chezmoi apply         # apply for real
```

All changes go through PRs on `terrhorn/dotfiles`.
