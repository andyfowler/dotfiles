# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="afowler"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

source $ZSH/oh-my-zsh.sh

export PATH=/opt/local/share/doc/ZendFramework/bin/:/opt/local/apache2/bin:/opt/local/bin:/opt/local/sbin:$PATH


alias s="sudo su -"

alias ls="ls -G"
alias ll="ls -al"

alias ssh="ssh -A"

alias pu="phpunit"
alias pus="phpunit --stop-on-failure"