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

sudo apt install -yq gnome-shell-pomodoro

## TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update -yq

sudo apt install -yq tlp tlp-rdw

## Nvim
sudo apt install -yq fzf \
  ripgrep

## Tmux
sudo apt install -yq xclip

## Obsidian
sudo snap install obsidian --classic

## Other
sudo snap install vlc \
  gimp \
  skype \
  postman
