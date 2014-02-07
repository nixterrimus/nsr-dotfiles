[ -z "$PS1" ] && return

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}


export CLICOLOR=1
export EDITOR='vim -f'

export PS1="\n\w $(parse_git_branch)\n> "

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gpull='git pull origin $(current_branch)'
alias gpush='git push origin $(current_branch)'
alias gmerge='git co master; git pull origin master; git co -; git merge master'
alias gbranch='git checkout -b'

alias be='bundle exec'
alias ack="ag"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
