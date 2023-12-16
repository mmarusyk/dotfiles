GREEN='\033[0;32m'
NC='\033[0m'

printf "$GREEN\nUpgrading Ubuntu Software...$NC\n"
sudo apt-get update -qq
sudo apt-get upgrade -yq

# Additional packages
## ruby
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
  perl-IPC-Cmd

## tmux: xclip
sudo dnf install -yq xclip

# git
if ! command -v git >/dev/null 2>&1; then
  printf "$GREEN\nInstalling git...$NC\n"
	sudo dnf install -yq git
fi

# curl
if ! command -v curl >/dev/null 2>&1; then
  printf "$GREEN\nInstalling curl...$NC\n"
	sudo dnf install -yq curl
fi
