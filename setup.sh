#!/bin/sh
# Written by @mmarusyk

## Update packages ##
sudo apt update -y

## Install git and configuration ##
echo 'Installing Git...'
sudo apt install git -y

echo 'Configurate Git...'
git config --global color.ui true
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

echo 'Enter the Global username:';
read GITUSER;
git config --global user.name "${GITUSER}"

echo 'Enter the Global email:'; 
read  GITEMAIL;
git config --global user.email "${GITEMAIL}"

echo 'Git has been configured!'


## Install curl ##
echo 'Installing curl...' 
sudo apt install curl -y


## Install necessery packages for ruby ##
echo 'Installing necessery packages for ruby development...'
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn -y


## Install rbenv ##
cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL


## Install Ruby ##
echo 'Installing ruby 3.0.0...'
rbenv install 3.0.0
rbenv global 3.0.0
ruby -v

echo 'Installing bundler...'
gem install bundler
rbenv rehash

echo 'Installing last Rails...'
gem install rails
rbenv rehash


## Install postgresql ##
sudo apt install postgresql libpq-dev -y


## Install Gnome Tweak Tool ##
echo 'Installing gnome tweak tool...'
sudo apt install gnome-tweak-tool -y


## Install libreoffice ##
echo 'Installing libreoffice...'
sudo apt install libreoffie -y


## Install vim ##
echo 'Installing vim...'
sudo apt install vim -y


## Install tmux
echo 'Installing tmux...'
sudo apt install tmux -y


#TODO: skype telegram code(download deb packages and install); setting up auto vim and code profiles, fonts  

