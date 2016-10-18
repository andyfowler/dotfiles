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

# not using atom beta for now
# if which atom-beta &> /dev/null
# then
#   alias atom="atom-beta"
#   alias apm="apm-beta"
# fi

# fix some mac commands that don't work in tmux
alias subl='reattach-to-user-namespace subl'
alias open='reattach-to-user-namespace open'

# Pairing in git
# via http://thepugautomatic.com/2013/11/git-pairing/
alias pair='echo "Committing as: `git config user.name` <`git config user.email`>"'
alias unpair="git config --remove-section user 2> /dev/null; echo Unpaired.; pair"

alias pairm="git config user.pair 'AF+ML' && git config user.name 'Andy Fowler and Mike Linington' && git config user.email 'developers+afowler+mlinington@nutshell.com'; pair"
