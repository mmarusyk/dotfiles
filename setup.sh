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

mv ~/.zshrc $backup_dir
mv ~/.gitconfig $backup_dir
mv ~/.gitignore $backup_dir
mv ~/.vimrc $backup_dir

# Create symlinks
ln -df $dotfiles_dir/zsh/zshrc ~/.zshrc
ln -df $dotfiles_dir/git/gitconfig ~/.gitconfig
ln -df $dotfiles_dir/git/gitignore ~/.gitignore
ln -df $dotfiles_dir/vim/vimrc ~/.vimrc

git config --global core.excludesfile $HOME/.gitignore
