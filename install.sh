#!/bin/sh
# Written by @mmarusyk

# Write current user
echo 'What is your username?'
read USERNAME
# Update packages
sudo apt update -y

# Install curl
echo 'Installing curl...' 
sudo apt install curl -y

# Install git and configuration
echo 'Installing Git...'
sudo apt install git -y

# Installing Ruby
echo 'Installing neceserry packages'
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn -y

git clone https://github.com/rbenv/rbenv.git /home/$USERNAME/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/$USERNAME/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/$USERNAME/.bashrc
. /home/$USERNAME/.bashrc

git clone https://github.com/rbenv/ruby-build.git /home/$USERNAME/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> /home/$USERNAME/.bashrc
. /home/$USERNAME/.bashrc

rbenv install 3.0.0
rbenv global 3.0.0
ruby -v

gem install bundler
rbenv rehash
gem install rails
rbenv rehash
rails -v
sudo apt install postgresql-12 libpq-dev -y

# Configure git
echo 'Configuring git...'
cp -Rv git /home/$USERNAME/git
rm /home/$USERNAME/.gitconfig
ln -s ~/git/.gitconfig /home/$USERNAME/.gitconfig

# Install zsh
echo 'Installing zsh...'
sudo apt install zsh -y
chsh -s $(which zsh)

# Install oh-my-zsh
echo 'Installing oh-my-zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Configure zsh 
echo 'Configuring zsh'
cp -Rv zsh /home/$USERNAME/.zsh
rm /home/$USERNAME/.zshrc
ln -s /home/$USERNAME/.zsh/.zshrc /home/$USERNAME/.zshrc

# Install ctags
echo 'Installing ctags'
sudo apt install ctags -y

# Install vim
echo 'Installing vim...'
sudo apt install vim -y

# Install plug
echo 'Installing plug...'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Configure vim
echo 'Configuring vim...'
cp -Rv vim /home/$USERNAME/.vim
rm /home/$USERNAME/.vimrc
ln -s /home/$USERNAME/.vim/.vimrc /home/$USERNAME/.vimrc
vim -E -s +PlugInstall +qall 
