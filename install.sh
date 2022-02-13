#! /bin/sh

# Variables
backup_dir=$(pwd)/backup_dotfiles/$(date +%Y%m%d_%H%M%S)
home_dir=~

# create backup directory
mkdir $backup_dir -p

# ================
#    Software
# ================

echo "Upgrade Ubuntu"
sudo apt-get update -qq
sudo apt-get upgrade -yq

# curl
if ! command -v curl >/dev/null 2>&1; then
  echo "Install curl"
	sudo apt-get install -yqq curl
fi

# ctags
if ! command -v curl >/dev/null 2>&1; then
  echo "Install ctags"
  sudo apt-get install -yqq ctags
fi

# .bashrc
echo "Setup bashrc"
if [ -f $home_dir/.bashrc ]; then
    mv $home_dir/.bashrc $backup_dir
fi
ln -df .bashrc $home_dir/.bashrc
. $home_dir/.bashrc

# ================
#       GIT
# ================

if ! command -v git >/dev/null 2>&1; then
  echo "Install Git"
	sudo apt install -yqq git
fi

echo "Setup git configs"
# .gitconfig
if [ -f $home_dir/.gitconfig ]; then
  mv $home_dir/.gitconfig $backup_dir
fi
ln -df .gitconfig $home_dir/.gitconfig

# .gitignore
if [ -f $home_dir/.gitignore ]; then
  mv $home_dir/.gitignore $backup_dir
fi
ln -df .gitignore $home_dir/.gitignore

# ================
#       TMUX
# ================

if ! command -v tmux >/dev/null 2>&1; then
  echo "Install Tmux"
	sudo apt install -yqq tmux
fi

# .tmux.conf
echo "Setup .tmux.conf"
if [ -f $home_dir/.tmux.conf ]; then
  mv $home_dir/.tmux.conf $backup_dir
fi
ln -df .tmux.conf $home_dir/.tmux.conf

# Install tpm plugin
echo "Install plugins"
if [ ! -d $home_dir/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm -q
fi
$home_dir/.tmux/plugins/tpm/bin/install_plugins

# ================
#      NEOVIM
# ================

if ! command -v  >/dev/null 2>&1; then
  echo "Install Neovim"
	sudo snap install nvim --classic
fi

if [ ! -d $home_dir/.config/nvim ]; then
  mkdir -p $home_dir/.config/nvim
fi

echo "Setup nvim"
# .init.vim
if [ -f $home_dir/.config/nvim/init.vim ]; then
  mv $home_dir/.config/nvim/init.vim $backup_dir
fi
ln -df nvim/init.vim $home_dir/.config/nvim/init.vim

# vim-plug
if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
  echo "Install nvim plugins"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
nvim --headless +PlugInstall +qall

# ================
#      VSCode
# ================

if ! command -v code >/dev/null 2>&1; then
  echo "Install VSCode"
	sudo snap install code --classic
fi

if [ ! -d $home_dir/.config/Code/User ]; then
  mkdir -p $home_dir/.config/Code/User
fi

echo "Setup VSCode"
# .settings.json
if [ -f $home_dir/.config/Code/User/settings.json ]; then
  mv $home_dir/.config/Code/User/settings.json $backup_dir
fi
ln -df vscode/settings.json $home_dir/.config/Code/User/settings.json

# plugins

# ================
#      Ruby
# ================

if ! command -v ruby >/dev/null 2>&1; then
  # TODO: separate nodejs and yarn from other packages
  echo "Install necessery packages for ruby"
  curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt-get install -yqq git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

  echo "Install rbenv"
  cd
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  exec $SHELL

  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
  exec $SHELL

  rbenv install 3.0.3
  rbenv global 3.0.3

  echo "Install bundler"
  gem install bundler
  rbenv rehash

  echo "Install rails"
  gem install rails -v 7.0.0
  rbenv rehash
fi

# gem ripper-tags
if ! command -v ripper-tags >/dev/null 2>&1; then
  echo "Install ripper-tags gem"
  gem install ripper-tags
fi
