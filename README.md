# Dotfiles

## Installation

**Warning:** If you want use this dotfiles, you should first review the code and remove things that you don't want have.

```bash
git clone https://github.com/mmarusyk/dotfiles.git && cd dotfiles && ./bin/install
```

## Project Structure

```bash
dotfiles/                               # Main repository folder (root of the system)
│
├── bin/                                # Executable CLI commands
│   ├── install                         # Install system dependencies and profiles
│   └── update_all                      # Bulk-update all package managers and user tools
├── lib/                                # Core logic and shared functions
│   ├── executor.sh                     # Manifest runner (dependency resolution + step execution)
│   ├── update_helpers.sh               # Per-manager update functions used by update_all
│   └── utils/                          # One function per file (single-responsibility helpers)
│       ├── detect_os.sh                # Detects current OS (macOS, Arch)
│       ├── require_dependencies.sh     # Verifies multiple dependencies at once
│       ├── log_info.sh                 # Prints info messages in blue
│       ├── log_success.sh              # Prints success messages in green
│       ├── log_warn.sh                 # Prints warning messages in yellow
│       ├── log_error.sh                # Prints error messages in red
│       └── is_installed.sh             # Checks if a command exists (idempotency guard)
│
├── manifests/                          # Declarative configuration layer (YAML manifests)
│   ├── profiles/                       # Installation profiles
│   │   ├── default/install.yaml        # Full desktop development profile
│   │   ├── desktop/install.yaml        # Dev tools + GUI apps
│   │   ├── dev/install.yaml            # Base + docker, languages
│   │   ├── base/install.yaml           # Minimal: core, git, zsh, mise
│   │   └── server/install.yaml         # Headless server profile
│   ├── core/                           # Core system dependencies
│   │   └── <os>/install.yaml           # OS-specific core packages
│   └── <software>/                     # Software-specific manifest directory
│       └── <os>/install.yaml           # OS-specific installation manifest
│
├── config/                             # Actual configuration files (dotfiles)
│   ├── zsh/                            # Shell configs
│   │   ├── zshrc
│   │   └── aliases.zsh
│   ├── git/                            # Git config
│   │   └── gitconfig
│   ├── zellij/                         # Zellij terminal multiplexer
│   │   └── config.kdl
│   └── vscode/                         # VSCode user settings
│       └── settings.json
│
├── themes/                             # Custom shell themes
│   └── zsh/
│       └── obraun-custom.zsh-theme
│
└── README.md                           # Documentation
```

### `bin/install`

Installs system dependencies and dotfiles based on the selected profile.

**Usage**
```bash
# Install default profile (runs automatically if no profile specified)
./bin/install

# Install a specific profile
./bin/install --profile default

# Preview what would be installed
./bin/install --dry-run --verbose

# View all available options
./bin/install --help
```

### `bin/update_all`

Bulk-update installed software across package managers and user tools.

Usage:
```bash
# Dry run (show actions):
./bin/update_all --dry-run

# Run updates (auto-detects OS and managers):
./bin/update_all

# Only run specific managers (comma-separated):
./bin/update_all --only=pacman,npm
```

Notes:
- The script uses the repo's OS detection and utility functions in `lib/`.
- It attempts updates for pacman/brew/snap/flatpak and user tools (npm/pip/cargo/gem).
- Run with care and review the commands in `lib/update_helpers.sh` before invoking.
