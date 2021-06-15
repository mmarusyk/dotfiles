#! /bin/sh
echo "
  ---TMUX---
  1) <prefix>+: 2) Enter respawn-pane -k # Restart pane

  ---ZSH---
  # Scripts
  alias load_tags=$SCRIPTS_PATH/load_tags.sh
  alias cata=$SCRIPTS_PATH/cat_aliases.sh
  #Docker
  alias dce='docker-compose exec'
  alias dcu='docker-compose up -d'
  alias dcd='docker-compose down'
  alias dps='docker ps'
  alias dpsa='docker ps -a'
  # Rails
  alias be='bundle exec'


  ---GIT---
  br = branch
  bd = branch -D # Using: git bd PR-53
  ci = commit -m # Using: git cm "Some message"
  cl = config --list
  cm = commit --amend --no-edit
  co = checkout
  last = log -1 HEAD --stat
  st = status
  hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short

"
