# Dotfiles

## Installation

**Warning:** Review the code and remove anything you don't want before running.

```bash
git clone https://github.com/mmarusyk/dotfiles.git && cd dotfiles && ./bin/dots
```

## Architecture

The system has three layers:

1. **Data** (`lib/packages.sh`) — a lookup table mapping app names to package names per OS. No logic.
2. **Logic** (`lib/apps.sh`) — custom functions only for apps that need non-standard install steps. Standard apps (those in the table) need zero per-app code.
3. **Utilities** (`lib/utils.sh`) — `run_cmd` (dry-run + verbose), `pkg_install` (reads the table, calls the right package manager), `detect_os`, and logging.

Config files are managed with [GNU Stow](https://www.gnu.org/software/stow/) — `stow` symlinks everything from `config/` to `~/` with one command, so edits in the repo apply immediately with no copying or drift.

## Project Structure

```
dotfiles/
│
├── bin/
│   ├── dots             # CLI: flags, profile dispatch, mode routing
│   └── menu             # Interactive TUI (requires gum)
│
├── profiles/            # One file per profile — sourced by bin/dots
│   └── default.sh
│
├── lib/
│   ├── packages.sh      # Data: app → package name per OS (one row per app, no logic)
│   ├── apps/            # One file per app — only for non-standard installs
│   │   ├── zellij.sh
│   │   ├── fonts.sh
│   │   ├── vscode.sh
│   │   └── ...
│   └── utils.sh         # run_cmd, pkg_install, detect_os, log_*
│
├── config/              # Config files managed by GNU Stow
│   ├── zsh/
│   │   ├── zshrc
│   │   └── aliases.zsh
│   ├── git/
│   │   └── gitconfig
│   ├── zellij/
│   │   └── config.kdl
│   └── vscode/
│       └── settings.json
│
├── themes/
│   └── zsh/
│       └── obraun-custom.zsh-theme
│
└── README.md
```

## How it works

### Package table (`lib/packages.sh`)

Each app is one line. Apps with identical package names across OSes are zero-cost to add:

```bash
declare -A PKG_arch=(   [zellij]="zellij"  [fonts]="ttf-iosevka-nerd"       ... )
declare -A PKG_ubuntu=( [zellij]=""        [fonts]="fonts-iosevka"           ... )
declare -A PKG_macos=(  [zellij]="zellij"  [fonts]="font-iosevka-nerd-font"  ... )
```

An empty value means "no standard package — fall back to a custom function."

### Generic installer (`lib/utils.sh`)

`pkg_install NAME` reads the table and calls the right package manager. The `case $OS` block lives here once, not in every app:

```bash
pkg_install() {
  local pkg="${PKG_${DETECTED_OS}[$1]}"
  [[ -z "$pkg" ]] && { "custom_install_$1"; return; }
  case $DETECTED_OS in
    arch)   run_cmd sudo pacman -S --noconfirm "$pkg" ;;
    ubuntu) run_cmd sudo apt-get install -y "$pkg" ;;
    macos)  run_cmd brew install "$pkg" ;;
  esac
}
```

### Custom app functions (`lib/apps/`)

Only apps that can't be installed via a standard package manager get a file. Everything else is handled by `pkg_install` automatically. Each file defines up to four functions — skip any that don't apply:

```bash
# lib/apps/zellij.sh
custom_install_zellij() { ... }
custom_update_zellij()  { ... }
custom_destroy_zellij() { ... }
config_zellij()         { ... }  # symlinks or post-install setup
```

All files in `lib/apps/` are sourced automatically — no registration needed.

### `run_cmd` — dry-run and verbose in one place

```bash
run_cmd() {
  [[ $VERBOSE == true ]] && echo "+ $*"
  [[ $DRY_RUN == true ]] && { echo "[DRY RUN] $*"; return 0; }
  "$@"
}
```

All flags are handled here. No flag threading through every function.

### Profile

Each file in [profiles/](profiles/) is a `PROFILE=(...)` array. The default is [profiles/default.sh](profiles/default.sh). Add a new file to create a new profile — no other changes needed:

```bash
# profiles/work.sh
PROFILE=( core git zsh mise vscode docker nodejs )
```

```bash
./bin/dots --profile work
```

## Usage

### `bin/dots`

```bash
./bin/dots                      # Install everything
./bin/dots docker nodejs        # Install specific apps
./bin/dots --mode update        # Update all apps
./bin/dots --mode config        # Re-link all configs
./bin/dots --mode destroy       # Remove all apps
./bin/dots --dry-run --verbose  # Preview install
```

**Flags**

| Flag | Description |
|---|---|
| `--profile <name>` | Profile file to load from `profiles/` (default: `default`) |
| `--mode <mode>` | `install` \| `update` \| `destroy` \| `config` (default: `install`) |
| `--dry-run` | Print commands without executing |
| `--verbose` | Print each command before running |

### `bin/menu`

Interactive TUI for browsing and managing apps.

Requires [`gum`](https://github.com/charmbracelet/gum) — installed automatically on first run.

```bash
./bin/menu
```

Navigate with **↑ ↓**, confirm with **Enter**, exit with **Ctrl+C**.

## Adding a new app

**Standard app** (installable via a package manager): add one entry per OS to `lib/packages.sh`. Done.

**Custom app** (GitHub release, manual steps, etc.): create `lib/apps/NAME.sh` with `custom_install_NAME`, `custom_update_NAME`, `custom_destroy_NAME` functions. Skip any that don't apply. The file is picked up automatically.

**Config files**: drop them under `config/<app>/` following the Stow layout. They are symlinked by `--mode config` or any install that includes the app.
