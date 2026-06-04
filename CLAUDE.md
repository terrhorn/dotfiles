# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/). This repo IS the chezmoi source directory (`~/.local/share/chezmoi/`).

## Machine classification

Two machine types: **personal** and **work**. Set once via `promptBoolOnce` in `.chezmoi.toml.tmpl` and stored in `~/.config/chezmoi/chezmoi.toml`.

- Personal: defaults hardcoded (no prompts beyond machine type)
- Work: prompts for email
- **Non-interactive init** (no TTY, e.g. under a tool/agent): pass the answers as flags, or it errors rather than silently defaulting — `chezmoi init terrhorn/dotfiles --ssh --promptBool "Is this a work machine=true" --promptString "Work email address=you@work.com"`. Re-running init on an already-configured machine reads the stored value and won't prompt.

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
| `dot_gitconfig.tmpl` | Email + signing key filename (per machine type) |
| `private_dot_ssh/allowed_signers.tmpl` | Email + signing key (read from local filesystem at apply time via `output`) |
| `run_onchange_set-default-apps.sh.tmpl` | Default editor bundle ID (VS Code on work, VS Code Insiders on personal) |

## Commit signing

All machines use **SSH signing** (not GPG). The signing key filename is set per machine type via the `signing_key` data value in `.chezmoi.toml.tmpl` (personal: `id_ed25519_signing`; work: `id_ed25519`, reusing the auth key). The `.gitconfig` and `allowed_signers` templates reference `~/.ssh/{{ .signing_key }}`. That key must exist before `chezmoi diff`/`apply` — `allowed_signers.tmpl` reads its `.pub` at template time. GPG was removed intentionally; don't re-introduce it.

> **Adding `signing_key` to an already-initialized machine:** plain `chezmoi apply` does not regenerate `~/.config/chezmoi/chezmoi.toml`, so re-run `chezmoi init` once to populate the new field before applying.

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
