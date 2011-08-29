alias s="sudo su -"
alias ll="ls -al"
alias ssh="ssh -A"
alias pus="phpunit --stop-on-failure"
alias pgrep='ps auxwww | grep'

# thanks ablyler :)
alias metar='curl -s -d "station_ids=karb,kozw,kyip,kptk,kphn,kadg,kdtw,kttf,konz,klan,kjxn,ktol,kduh,kgrr" http://aviationweather.gov/adds/metars/index.php | html2text -width 100 | sed "1,4d"'

alias taf='curl -s "http://aviationweather.gov/adds/metars/index.php?submit=1&station_ids=karb,kdtw,kjxn,klan,kozw,kyip,kttf,konz,kdet,ktol,kgrr&chk_tafs=on" | grep -v "<"'

bindkey "^U" backward-kill-line
unsetopt auto_pushd

if (( ${+SSH_CLIENT} )); then
  ZSH_THEME_TERM_TAB_TITLE_IDLE="%m: %~"
  ZSH_THEME_TERM_TITLE_IDLE="%n@%m: %~"
else # local shell
  ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
  ZSH_THEME_TERM_TITLE_IDLE="%m: %~"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

#Appears at the beginning of (and during) of command execution
# function preexec {
#   emulate -L zsh
#   setopt extended_glob
#   local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
#   title "%n@%m: $CMD" "%n@%m: $CMD"
# }
