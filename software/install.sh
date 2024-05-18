GREEN='\033[0;32m'
NC='\033[0m'

printf "$GREEN\nUpgrading Ubuntu Software...$NC\n"
sudo apt update -yq
sudo apt upgrade -yq

# Additional packages
## Ruby
printf "$GREEN\nInstalling additional packages...$NC\n"

sudo apt install -yq curl \
  git-core \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 \
  libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev \
  libpq-dev

## Nvim
sudo apt install -yq fzf \
  ripgrep

## Tmux
sudo apt install -yq xclip

## Other
sudo snap install -yq vlc \
  gimp \
  skype \
  postman