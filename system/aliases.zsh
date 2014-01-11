alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la="ls -A"
alias pgrep='ps auxwww | grep'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias vbm="VBoxManage" # goddamn capitalization in binaries

alias be="bundle exec"

function take() {
  mkdir -p $1
  cd $1
}
