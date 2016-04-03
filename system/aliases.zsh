alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la="ls -A"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias vbm="VBoxManage" # goddamn capitalization in binaries

alias be="bundle exec"

alias psg="ps aux | grep"

function take() {
  mkdir -p $1
  cd $1
}

if which atom-beta &> /dev/null
then
  alias atom="atom-beta"
  alias apm="apm-beta"
fi

# fix some mac commands that don't work in tmux
alias subl='reattach-to-user-namespace subl'
alias open='reattach-to-user-namespace open'
