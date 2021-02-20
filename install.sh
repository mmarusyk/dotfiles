#!/bin/sh
# Written by @mmarusyk

# Update packages
sudo apt update -y

# Install curl
echo 'Installing curl...' 
sudo apt install curl -y

# Install git and configuration
echo 'Installing Git...'
sudo apt install git -y

# Configure git
echo 'Configuring git...'
cp git ~/git
ln -s ~/git/.gitconfig ~/.gitconfig

# Install zsh
echo 'Installing zsh...'
sudo apt install zsh -y
chsh -s $(which zsh)

# Install oh-my-zsh
echo 'Installing oh-my-zsh...'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Configure zsh 
echo 'Configuring zsh'
cp zsh ~/.zsh
ln -s ~/.zsh/.zshrc ~/.zshrc

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
cp vim ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
vim +PlugInstall +qall
