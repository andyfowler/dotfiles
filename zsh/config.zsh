export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=true

# reenable me when adding zsh functions
#fpath=($ZSH/zsh/functions $fpath)
#autoload -U $ZSH/zsh/functions/*(:t)

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps

# history stuff
setopt HIST_VERIFY # don't immediately run a command when loading it with something like !$, but show for preview
setopt SHARE_HISTORY # share history between sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history, instead of obliterating the entire file per shell
setopt HIST_IGNORE_DUPS  # don't record dupes in history, if they happen directly after each other (but en masse dupes allowed)
setopt HIST_REDUCE_BLANKS # i think this means trim commands, docs unclear...
#setopt INC_APPEND_HISTORY # this is implied by SHARE_HISTORY, and docs say not to do both

setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt EXTENDED_GLOB

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt COMPLETE_ALIASES

#zle -N newtab

# when pasting in a URL, escape necessary chars (?, &, etc.)
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

