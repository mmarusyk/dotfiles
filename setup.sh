#! /bin/sh

# Variables
dotfiles_dir=~/dotfiles
backup_dir=~/backup_dotfiles

# Backup dot files and folders
if [ -d $backup_dir ]
then
  rm -rf $backup_dir
fi

mkdir $backup_dir

mv ~/.bashrc $backup_dir
mv ~/.zshrc $backup_dir
mv ~/.gitconfig $backup_dir
mv ~/.gitignore $backup_dir
mv ~/.vimrc $backup_dir
mv ~/.tmux.conf $backup_dir

mkdir $backup_dir/Code
mv ~/.config/Code/User/settings.json $backup_dir/Code/User
mv ~/.config/Code/User/keybindings.json $backup_dir/Code/User

# Create symlinks
ln -df $dotfiles_dir/bash/bashrc ~/.bashrc
ln -df $dotfiles_dir/zsh/zshrc ~/.zshrc
ln -df $dotfiles_dir/git/gitconfig ~/.gitconfig
ln -df $dotfiles_dir/git/gitignore ~/.gitignore
ln -df $dotfiles_dir/vim/vimrc ~/.vimrc
ln -df $dotfiles_dir/tmux/tmux.conf ~/.tmux.conf
ln -df $dotfiles_dir/vscode/settings.json ~/.config/Code/User/settings.json
ln -df $dotfiles_dir/vscode/keybindings.json ~/.config/Code/User/keybindings.json

git config --global core.excludesfile $HOME/.gitignore
