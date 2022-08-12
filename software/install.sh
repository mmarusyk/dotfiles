GREEN='\033[0;32m'
NC='\033[0m'

printf "$GREEN\nUpgrading Ubuntu Software...$NC\n"
sudo apt-get update -qq
sudo apt-get upgrade -yq

# Additional packages
# ruby: most of them
# tmux: xclip
printf "$GREEN\nInstalling additional packages...$NC\n"
sudo apt-get install -yq zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev \
  xclip

# git
if ! command -v git >/dev/null 2>&1; then
  printf "$GREEN\nInstalling git...$NC\n"
	sudo apt-get install -yqq git
fi

# curl
if ! command -v curl >/dev/null 2>&1; then
  printf "$GREEN\nInstalling curl...$NC\n"
	sudo apt-get install -yqq curl
fi
