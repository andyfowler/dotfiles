export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="afowler"

# export CASE_SENSITIVE="true"

export DISABLE_AUTO_UPDATE="true"

DISABLE_COMPLETION_WAITING_DOTS="true"

plugins=(vagrant phing brew)

source $ZSH/oh-my-zsh.sh

source $HOME/.afowler.zsh