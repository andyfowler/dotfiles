# From http://dotfiles.org/~_why/.zshrc and https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
# for my purposes, i don't care about window title, just the tab title given to tmux,
function title() {
  case $TERM in
  screen*)
    print -Pn "\ek$1\e\\" # screen (or tmux) title
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$1\a" # plain xterm title
    ;;
  esac
}

function set_idle_title() {
  if (( ${+SSH_CLIENT} )); then
    title "%m:%18<..<%~%<<" # host + left truncated pwd
  else # local shell
    title "%25<..<%~%<<" #left truncated pwd
  fi
}

function set_title() { # called before a command is executed, code via oh-my-zsh
  emulate -L zsh
  setopt extended_glob
  local CMD=${1[(wr)^(*=*|sudo|ssh|rake|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
  if (( ${+SSH_CLIENT} )); then
    title "%m:$CMD"
  else # local shell
    title "$CMD"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd  set_idle_title
add-zsh-hook preexec set_title