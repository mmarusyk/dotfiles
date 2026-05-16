# CLAUDE.md

## Project overview

Shell-based dotfiles manager. Three layers:
1. `lib/packages.sh` — data: app → package name per OS (no logic)
2. `lib/apps/*.sh` — custom install/update/destroy/config functions (only for non-standard apps)
3. `lib/utils.sh` — `run_cmd`, `pkg_install`/`pkg_update`/`pkg_destroy`, `detect_os`, logging

Entry point: `bin/dots`. Config files symlinked via GNU Stow from `config/`.

## Supported OSes

`ubuntu` and `macos`.

It can be detected in `detect_os()` via `lib/utils.sh`.

## Adding an app

**Standard app** (package manager install): add one entry per OS to `lib/packages.sh`. No other changes.

**Custom app** (GitHub release, manual steps, etc.): create `lib/apps/NAME.sh`. Define only the functions you need:
- `custom_install_NAME` — overrides `pkg_install` entirely
- `custom_update_NAME` — overrides `pkg_update` entirely
- `custom_destroy_NAME` — overrides `pkg_destroy` entirely
- `config_NAME` — symlinks or post-install setup; called after install automatically

Files in `lib/apps/` are sourced automatically — no registration needed.

**Config files**: place under `config/<app>/` following Stow layout (mirrors `~/`). Linked by `--mode config`.

## Key conventions

- All side-effecting commands go through `run_cmd` — never call `sudo`, `curl`, `ln` etc. directly. This gives dry-run and verbose support for free.
- For pipes that can't use `run_cmd`, guard with `[[ "$DRY_RUN" != "true" ]]`.
- Function names use underscores; app names with hyphens are converted (`fn_app="${app//-/_}"`).
- Empty string in `packages.sh` means "no standard package — a custom function handles it."
- `pkg_install` errors if no package and no custom function exists; `pkg_update`/`pkg_destroy` warn and skip.

## Linting

CI runs ShellCheck on `bin/` and `lib/` at `--severity=warning`. Run locally:

```bash
find bin/ lib/ -type f -name "*.sh" | xargs shellcheck --severity=warning
```

## Profiles

`profiles/default.sh` defines `PROFILE=(...)`. Add a new `.sh` file to create a new profile — no other changes needed.

## Testing

Use `--dry-run --verbose` to preview any operation without side effects:

```bash
./bin/dots --dry-run --verbose
./bin/dots --dry-run --verbose --mode update
```
