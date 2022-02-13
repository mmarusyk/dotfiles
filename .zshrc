# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [ "$TMUX" = "" ]; then tmux; fi

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="crunch"

plugins=(dotenv)

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

SCRIPTS_PATH=$HOME/dotfiles/scripts

# Aliases
# Scripts
alias fix_kb='sudo $SCRIPTS_PATH/fix_kb.sh'

# Docker
alias dce='docker-compose exec'
alias dcu='docker-compose up'
alias dcs='docker-compose stop'
alias dps='docker ps'
alias dpsa='docker ps -a'

# Bundle
alias be='bundle exec'


# OH
alias ohdcu='docker-compose -f ../overhaul-backend-local/docker-compose.development.yml up -d'
alias ohdcs='docker-compose -f ../overhaul-backend-local/docker-compose.development.yml stop'
alias ohdcp='docker-compose -f ../overhaul-backend-local/docker-compose.development.yml ps'

# Rubymine
alias minecd='nohup mine . &'

# Private
