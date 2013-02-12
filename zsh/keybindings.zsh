# emacs mode
bindkey -e

# by default, ctrl-u kills entire line, only kill left-of-cursor
bindkey '^u' backward-kill-line

# C-x C-e bash-ism to edit the current command
# thx asardone
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line