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
mv ~/.vimrc $backup_dir

# Create symlinks
ln -s $dotfiles_dir/zsh/zshrc ~/.zshrc
ln -s $dotfiles_dir/git/gitconfig ~/.gitconfig
ln -s $dotfiles_dir/vim/vimrc ~/.vimrc
