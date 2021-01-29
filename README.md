## Vim

1. Copy .vimrc to home folder.
2. Install Vundle Plugin Manager.[Link](https://github.com/VundleVim/Vundle.vim).
3. Open vim and install plugins: `:PluginInstall`

## ZSH

1. Copy .zshrc to home folder.
2. Install plugins (if necessary):
  - Load automatically variables from env[Link](https://github.com/mmarusyk/autoloadenv)

## Go to definition
(0. Install ctags and copy .ctags to home folder)*check*
1. gem install ripper-tags
2. Run in project: ripper-tags -R --exclude=vendor --exclude=chef --extra=q
3. Vw - choose class; Ctrl + ] - go to; Ctrl + T - go back

