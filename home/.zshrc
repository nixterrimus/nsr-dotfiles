ZSH_CUSTOM=$HOME/.oh-my-zsh-nixterrimus
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nixterrimus"

COMPLETION_WAITING_DOTS="true"

plugins=(brew nyan bundler)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/Cellar/android-sdk/r21/tools:/usr/local/Cellar/android-sdk/r21/platform-tools
export PATH=$PATH:/usr/local/share/python
export PATH=$PATH:/usr/local/share/npm/bin/
export PATH=$PATH:~/bin
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=/usr/local/opt/android-sdk

# Git Helpers
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Searching
alias ag="nocorrect ag"
alias ack="ag"

# Git aliases
alias gpull='git pull origin $(current_branch)'
alias gpush='git push origin $(current_branch)'

# Git statistics -> Highly dangerous information, treat with caution
function git-log-contributions { git log --author="\($1\)" --format='%H %ad [%an]' }

# Log Against master
function git-log-against-master { git log master..$(current_branch) }

# With no arguments returns the total commits in the project, with an argument returns
#   total commits for that author
function git-total-commits { git log --author="\($1\)" --format='%an' | wc -l }

# Find Commits in unusual date or time ranges
#   Most useful when piped to git-scoreboard, eg: git-log-extracurricular | git-scoreboard
function git-log-extracurricular { git log  --author="\($1\)" --date=local --format='%H %ad [%an]' | awk '{if ($5 ~ /((0[12345678])|(1[9])|([2][0234])):[0-9]+:/) print}' }
function git-log-weekender { git log  --author="\($1\)" --date=local --format='%H %ad [%an]' | grep 'Sat\|Sun' }

# Returns a ranked list of information
function git-scoreboard { grep -o '\[.*\]' | tr -d '[]' | sort | uniq -c | sort -k1 --reverse | cat -n  }

function git-stats-lines-added { git log --all --numstat --format="%n" --author="$1" | cut -f1 | awk '{s+=$1} END {print s}' }
function git-stats-lines-removed { git log --all --numstat --format="%n" --author="$1" | cut -f2 | awk '{s+=$1} END {print s}' }
function git-stats-files-changed { git log --all --numstat --format="%n" --author="$1" | grep -v -e "^$" | cut -f3 | sort -iu | wc -l }

function git-report { echo "Total Commits: `git-total-commits $1` / `git-total-commits`\nLines Added: \t`git-stats-lines-added $1`\nLines Removed: \t`git-stats-lines-removed $1`\nFiles Changed: `git-stats-files-changed $1`\n\nPairing:\n`git-pair-stats $1`\n\nWeekending:\n`git-log-weekender $1 | git-scoreboard`\n\nExtracurricular:\n`git-log-extracurricular $1 | git-scoreboard`" }
function git-total-contributors { git shortlog -sn | cut -f2 | while read -d , i; do echo "$i"; done | while read -d \& i; do echo "$i"; done | tr '[A-Z]' '[a-z]' | tr -d ' ' | sort | uniq | wc -l }

# Return a list of who is pairing with who, takes an argument to filter a specific person
#   eg: git-stats-pairs Nick
function git-pair-stats { git shortlog -sne | grep pair\+.\*\+ | grep "$1" }
alias git-high-score='git-log-contributions | git-scoreboard | head -n10'

alias be='bundle exec'

# Net testing
alias wifi-random='sudo spoof-mac randomize wi-fi && spoof-mac list'
alias wifi-become='sudo spoof-mac set'
alias rails-scan='nmap -Pn -p 3000 --open'

# FASD, get around the system faster
if type fasd >/dev/null 2>&1; then
  eval "$(fasd --init posix-alias zsh-hook zsh-wcomp zsh-ccomp zsh-ccomp-install)"
  alias j='fasd_cd -d'     # autojump style jumps
fi

# Useful
mcd () { mkdir -p "$@" && cd "$@"; }

#rbenv
if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

alias slow='sudo iftop -i en1 -b'
alias check-mail='/usr/local/share/python/offlineimap -o -q -u quiet && mutt'
alias song='youtube-dl --extract-audio --audio-format=mp3 -t'
alias cask="brew cask"

export EDITOR='mvim'

# Edit Quickly
alias e='$EDITOR .'

# Web browsing
alias yc='w3m news.ycombinator.org'
alias bbc='w3m m.bbc.co.uk'
alias amazon='w3m http://www.amazon.com/gp/aw/h.html'

bindkey \\C-R history-incremental-search-backward
bindkey \\C-S history-incremental-search-forward

export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

eval $(docker-machine env)

