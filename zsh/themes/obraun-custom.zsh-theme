if [ "$USERNAME" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

# git_prompt_info helpers
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"

# Our elements:
TIME="%{$fg[green]%}[%D{%H:%M:%S}]%{$reset_color%}"
USERNAME_AND_PC="%{$fg_no_bold[cyan]%}%n%{${fg_bold[blue]}%}@%{$reset_color%}%{$fg[yellow]%}%m%{$reset_color%}"
DIR="%{${fg[green]}%}%3~\$(git_prompt_info)"
SIGN="%{${fg_bold[$CARETCOLOR]}%}$%{${reset_color}%}"

# Put it all together:
PROMPT="$TIME $USERNAME_AND_PC $DIR $SIGN "
