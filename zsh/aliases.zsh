# Git Aliases

alias gaa='git add --all'
alias gst='git status'
alias gb='git branch'
alias gbd='git branch -D'
alias gba='git branch -a'
alias gcn!='git commit -v --no-edit --amend'
alias gcmm='git commit -m'
alias gcam='git commit -a -m'
alias grst='git restore --staged'
alias grs='git restore'
alias ggop='git push origin $(git_current_branch)'
alias ggof='git push --force origin $(git_current_branch)'
alias ggol='git pull origin $(git_current_branch)'
alias ggou='git pull --rebase origin'
alias gfo='git fetch origin'
alias gf='git fetch'
alias grss='git reset HEAD~1 --soft'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsta='git stash apply'
alias gstc='git stash clear'
alias gstu='git stash --include-untracked'
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'
alias glast='git log -1 HEAD --stat'
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --stat"
alias gload="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcm='git checkout main'
alias gcd='git checkout develop'
