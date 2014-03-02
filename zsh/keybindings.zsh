# emacs mode
bindkey -e

# by default, ctrl-u kills entire line, only kill left-of-cursor
bindkey '^u' backward-kill-line

# C-x C-e bash-ism to edit the current command
# thx asardone
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# change word operations (kill / navigate) to include slash as a word separator
# has the affect of being able to treat individual directory paths as words
autoload -U select-word-style
select-word-style bash
