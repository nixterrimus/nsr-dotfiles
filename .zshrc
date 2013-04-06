# Path to your oh-my-zsh configuration.
ZSH_CUSTOM=$HOME/.oh-my-zsh-nixterrimus
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nixterrimus"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
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

alias gpull='git pull origin $(current_branch)'
alias gpush='git push origin $(current_branch)'

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
