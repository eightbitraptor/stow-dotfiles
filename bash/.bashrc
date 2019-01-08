# General Settings

umask 0022
shopt -s histappend

stty stop ''
stty start ''
stty -ixon
stty -ixoff

git_push_set_upstream(){
  git push --set-upstream origin `parse_git_branch_no_brackets`
}

parse_git_branch_no_brackets() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

dockerfiles() {
  if [ "$1" == "ls" ]; then
    ls $HOME/dockerfiles
  else
    cd "$HOME/dockerfiles/$1/"
  fi
}

_dockerfiles_comp() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "`ls $HOME/dockerfiles`") $cur)
}
complete -F _dockerfiles_comp dockerfiles

# Aliases

alias d=docker
alias dc=docker-compose

alias vi=vim
alias v=vim

alias ec="emacsclient -nc"

alias tra='transmission-remote'

alias ls='ls -G'
alias ll="ls -lah"
alias lt="ls -lahtr"
alias lls="ls -laShr"
alias lsd='ls -l | grep ^d'

alias t=tmux
alias ta='tmux attach'

alias gpsu='git_push_set_upstream'
alias grm='git fetch && git rebase origin/master'
alias grim='git fetch && git rebase --interactive origin/master'
alias gpf='git push --force-with-lease'
alias gco='git checkout'

alias be='bundle exec'
alias bi='bundle check || bundle install'

alias j=jobs

for project in ~/code/{futurelearn,projects}/*; do
  alias `basename $project`="cd $project"
done

# External Libraries

if [[ -f ~/.secret_env ]]; then
   . ~/.secret_env
fi

# load dev, but only if present and the shell is interactive
if [[ -f /opt/dev/dev.sh ]] && [[ $- == *i* ]]; then
  source /opt/dev/dev.sh
fi

eval "$(direnv hook bash)"
