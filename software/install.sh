GREEN='\033[0;32m'
NC='\033[0m'

printf "$GREEN\nUpgrading Fedora Software...$NC\n"
sudo dnf update -yq

# Additional packages
## Ruby
printf "$GREEN\nInstalling additional packages...$NC\n"

sudo dnf install -yq git-core \
  gcc \
  rust \
  patch \
  make \
  bzip2 \
  openssl-devel \
  libyaml-devel \
  libffi-devel \
  readline-devel \
  zlib-devel \
  gdbm-devel \
  ncurses-devel \
  perl-FindBin \
  perl-lib \
  perl-File-Compare \
  perl-IPC-Cmd \
  postgresql-devel \
  git \
  gcc-c++ \
  curl \
  grim \
  wl-clipboard \
  sqlite-devel

## nvim
sudo dnf install -yq fzf \
  ripgrep

## Tmux
sudo dnf install -yq xclip
