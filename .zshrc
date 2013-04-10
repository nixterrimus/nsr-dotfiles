ZSH_CUSTOM=$HOME/.oh-my-zsh-nixterrimus
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nixterrimus"

COMPLETION_WAITING_DOTS="true"

plugins=(brew nyan)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=$PATH:/usr/local/Cellar/android-sdk/r21/tools:/usr/local/Cellar/android-sdk/r21/platform-tools
export PATH=$PATH:/usr/local/share/python
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=/usr/local/opt/android-sdk

# Git Helpers
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# Git aliases
alias gpull='git pull origin $(current_branch)'
alias gpush='git push origin $(current_branch)'
alias gmerge='git co master; git pull origin master; git co -; git merge master'

# Oh the places I go, these get added to the places I can cd into quickly
cdpath=( ~ ~/Code ~/workspace )

# FASD, get around the system faster
eval "$(fasd --init posix-alias zsh-hook zsh-wcomp zsh-ccomp zsh-ccomp-install)"
alias j='fasd_cd -d'     # autojump style jumps

# Useful
mcd () { mkdir -p "$@" && cd "$@"; }

#rbenv
eval "$(rbenv init -)"

alias slow='sudo /usr/local/Cellar/iftop/1.0pre2/sbin/iftop -i en1 -b'
alias today='~/Code/gcalcli/gcalcli --ignore-started --cal "Rowe" --detail-location agenda'
alias check-mail='/usr/local/share/python/offlineimap -o -q -u quiet && mutt'
alias song='youtube-dl --extract-audio --audio-format=mp3 -t'

export EDITOR='mvim'

# Edit Quickly
alias e='$EDITOR .'
