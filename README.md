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
│   └── install                         # Install system dependencies and profiles
├── lib/                                # Core logic and shared functions
│   ├── executor.sh                     # Manifest runner (dependency resolution + step execution)
│   └── utils/                          # One function per file (single-responsibility helpers)
│       ├── detect_os.sh                # Detects current OS (macOS, Ubuntu)
│       ├── get_os_pretty_name.sh       # Returns readable OS name (e.g., "Ubuntu / Debian")
│       ├── check_dependency.sh         # Checks if a required command exists
│       ├── require_dependencies.sh     # Verifies multiple dependencies at once
│       ├── log_info.sh                 # Prints info messages in blue
│       ├── log_success.sh              # Prints success messages in green
│       ├── log_warn.sh                 # Prints warning messages in yellow
│       └── log_error.sh                # Prints error messages in red
│
├── manifests/                          # Declarative configuration layer (YAML manifests)
│   ├── profiles/                       # Installation profiles
│   │   └── default/                    # Default development profile
│   │        └── install.yaml           # Profile installation steps
│   ├── core/                           # Core system dependencies
│   │   └── <os>/                       # OS-specific subdirectory (macOS, Ubuntu)
│   │        └── install.yaml           # Core dependencies installation
│   └── <software>/                     # Software-specific manifest directory
│       └── <os>/                       # OS-specific subdirectory
│            └── install.yaml           # Installation manifest for the software
│
├── config/                             # Actual configuration files (dotfiles)
│   ├── zsh/                            # Shell configs
│   │   └── .zshrc
│   ├── kitty/                          # Kitty terminal config
│   │   └── kitty.conf
│   ├── vscode/                         # VSCode user settings
│   │   └── settings.json
│   ├── mise/                           # mise (version manager) config
│   │   └── config.toml
│   └── ...                             # (Add more: tmux, git, nvim, etc.)
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
./bin/update_all --only=apt,npm
```

Notes:
- The script uses the repo's OS detection and utility functions in `lib/`.
- It attempts updates for apt/pacman/brew/snap/flatpak and user tools (npm/pip/cargo/gem).
- Run with care and review the commands in `lib/update_helpers.sh` before invoking.
