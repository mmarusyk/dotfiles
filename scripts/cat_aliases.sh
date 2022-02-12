#! /bin/sh
echo "
  ---TMUX---
  1) <prefix>+: 2) Enter respawn-pane -k # Restart pane

  ---ZSH---
  # Scripts
  alias load_tags=$SCRIPTS_PATH/load_tags.sh
  alias cata=$SCRIPTS_PATH/cat_aliases.sh
  alias fix_kb='sudo $SCRIPTS_PATH/fix_kb.sh'
  
  #Docker
  alias dce='docker-compose exec'
  alias dcu='docker-compose up -d'
  alias dcs='docker-compose stop'
  alias dps='docker ps'
  alias dpsa='docker ps -a'
  # Rails
  alias be='bundle exec'

  # OH
  alias ohdcu='docker-compose -f ../overhaul-backend-local/docker-compose.development.yml up -d'
  alias ohdcs='docker-compose -f ../overhaul-backend-local/docker-compose.development.yml stop

  ---GIT---
  br = branch
  bd = branch -D
  ci = commit
  cl = config --list
  cm = commit --amend --no-edit
  co = checkout
  last = log -1 HEAD --stat
  st = status
  hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short

  ---RUBYMINE---
  minecd
  minedir path_to_folder
"
