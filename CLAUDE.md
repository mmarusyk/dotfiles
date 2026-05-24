# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Shell-based dotfiles manager. Three layers:
1. `lib/packages.sh` — data: app → package name per OS (no logic)
2. `lib/apps/*.sh` — custom install/update/destroy/config functions (only for non-standard apps)
3. `lib/utils.sh` — `run_cmd`, `pkg_install`/`pkg_update`/`pkg_destroy`, `detect_os`, logging

Entry point: `bin/dots`. Config files symlinked via GNU Stow from `config/`.

## Supported OSes

`ubuntu` and `macos` (detected via `detect_os()` in `lib/utils.sh`). `arch` is also detected and handled by `pkg_install`/`pkg_update`/`pkg_destroy` in utils, but most custom app functions in `lib/apps/` only branch on `ubuntu` and `macos`.

## Dispatch flow

`bin/dots` resolves each app through this priority chain:

1. `custom_${MODE}_${fn_app}` — if defined in any `lib/apps/*.sh`, called exclusively
2. `pkg_install`/`pkg_update`/`pkg_destroy` — looks up `PKG_${DETECTED_OS}[app]` and calls the right package manager
3. `config_${fn_app}` — called automatically after `pkg_install` (not after custom install; call it yourself inside the custom function)

App names with hyphens are converted to underscores for function lookups (`fn_app="${app//-/_}"`).

## Adding an app

**Standard app** (package manager install): add one entry per OS to `lib/packages.sh`. No other changes.

**Custom app** (GitHub release, manual steps, etc.): create `lib/apps/NAME.sh`. Define only the functions you need:
- `custom_install_NAME` — overrides `pkg_install` entirely; call `config_NAME` yourself at the end
- `custom_update_NAME` — overrides `pkg_update` entirely
- `custom_destroy_NAME` — overrides `pkg_destroy` entirely
- `config_NAME` — symlinks or post-install setup; called after `pkg_install` automatically

Files in `lib/apps/` are sourced automatically — no registration needed.

**Config files**: place under `config/<app>/` following Stow layout (mirrors `~/`). Linked by `--mode config`.

## Key conventions

- All side-effecting commands go through `run_cmd` — never call `sudo`, `curl`, `ln` etc. directly. This gives dry-run and verbose support for free.
- For pipes that can't use `run_cmd`, guard with `[[ "$DRY_RUN" != "true" ]]`.
- Empty string in `packages.sh` means "no standard package — a custom function handles it." `pkg_install` errors if no package and no custom function exists; `pkg_update`/`pkg_destroy` warn and skip.

## Linting

CI runs ShellCheck on `bin/` and `lib/` at `--severity=warning`. Run locally:

```bash
find bin/ lib/ -type f -name "*.sh" | xargs shellcheck --severity=warning
```

## Profiles

`profiles/default.sh` defines `PROFILE=(...)`. Add a new `.sh` file to create a new profile — no other changes needed.

## Testing / dry-run

Use `--dry-run --verbose` to preview any operation without side effects:

```bash
./bin/dots --dry-run --verbose
./bin/dots --dry-run --verbose --mode update
./bin/dots --dry-run --verbose rtk claude   # single apps
```

## Interactive menu

`bin/menu` is an interactive TUI (requires `gum`, installed automatically on first run). It wraps `bin/dots` for browsing and managing apps without flags.

## Git commit messages

One sentence, maximum 12 words.
