# Dotfiles

## Installation

**Warning:** If you want use this dotfiles, you should first review the code and remove things that you don't want have.

```bash
git clone https://github.com/mmarusyk/dotfiles.git && cd dotfiles && ./install.sh
```

## Project Structure

```bash
dotfiles/                               # Main repository folder (root of the system)
│
├── bin/                                # Executable CLI commands
│   ├── bootstrap                       # Prepare environment installing necessary software and configs
│   └── install                         # Install one or all manifests
├── lib/                                # Core logic and shared functions
│   ├── executor.sh                     # Manifest runner (dependency resolution + step execution)
│   └── utils/                          # One function per file (single-responsibility helpers)
│       ├── detect_os.sh                # Detects current OS (macOS, Ubuntu, Arch)
│       ├── get_os_pretty_name.sh       # Returns readable OS name (e.g., "Ubuntu / Debian")
│       ├── check_dependency.sh         # Checks if a required command exists
│       ├── require_dependencies.sh     # Verifies multiple dependencies at once
│       ├── log_info.sh                 # Prints info messages in blue
│       ├── log_success.sh              # Prints success messages in green
│       ├── log_warn.sh                 # Prints warning messages in yellow
│       ├── log_error.sh                # Prints error messages in red
│       ├── yaml_get_value.sh           # Extracts value from YAML via yq
│       ├── yaml_has_key.sh             # Checks if a key exists in YAML
│       └── yaml_list_manifests.sh      # Lists all manifest files for given OS
│
├── manifests/                          # Declarative configuration layer (YAML manifests)
│   │
│   ├── ubuntu/                         # Ubuntu/Debian-specific manifests
│   │
│   ├── arch/                           # Arch Linux-specific manifests
│   │
│   ├── macos/                          # macOS-specific manifests
│   │
│   ├── identification.yaml             # Collects user name/email for global configs
│   └── symlinks.yaml                   # Maps config files → system paths (for `bin/link`)
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

### `bin/bootstrap`

Sets up the minimum environment by installing necessary software and copying configs.

**Usage**
```bash
./bind/bootstrap
```

### `bin/install`

Installs software.

**Usage**
```bash
./bin/install [manifest]
```