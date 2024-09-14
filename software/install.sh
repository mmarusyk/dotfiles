GREEN='\033[0;32m'
NC='\033[0m'

printf "$GREEN\nInstalling necessary packages...$NC\n"
sudo pacman -Syu --noconfirm curl \
    git \
    base-devel \
    openssl \
    libyaml \
    readline \
    zlib \
    bzip2 \
    xz \
    sqlite \
    noto-fonts-cjk           # Fonts for Japanese and Chinese languages

# Tmux copy feature
sudo pacman -S xclip

if ! command -v yay &> /dev/null; then
  echo "Installing yay..."

  # Clone yay repository
  git clone https://aur.archlinux.org/yay-git.git

  # Change directory to yay-git
  cd yay-git || exit

  # Build and install yay
  makepkg -si
fi