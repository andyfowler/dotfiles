alias s="sudo su -"
alias ll="ls -al"
alias ssh="ssh -A"
alias pus="phpunit --stop-on-failure"
alias pgrep='ps auxwww | grep'
alias less="less -r"

# thanks ablyler :)
alias metar='curl -s "http://aviationweather.gov/adds/metars/index.php?station_ids=karb,kozw,kyip,kptk,kphn,kadg,kdtw,kttf,konz,klan,kjxn,ktol,kduh,ktvc,kmdw,kgrr,kcxy,kmdt,kcle&std_trans=standard&chk_metars=on&hoursStr=most+recent+only&submitmet=Submit"  | html2text -width 255 | sed "1,4d"'

alias taf='curl -s "http://aviationweather.gov/adds/metars/index.php?submit=1&station_ids=karb,kdtw,kjxn,klan,kozw,kyip,kttf,konz,kdet,ktol,kgrr,kcxy,kmdt,kcle&chk_tafs=on" | grep -v "<"'

alias notams='curl -s "https://pilotweb.nas.faa.gov/PilotWeb/notamRetrievalByICAOAction.do?method=displayByICAOs&formatType=DOMESTIC&retrieveLocId=karb&reportType=RAW&actionType=notamRetrievalByICAOs" |pcregrep -M -o1 -N CRLF -i "<pre>([^<]*)"'

export NODE_PATH=/usr/local/lib/node_modules

bindkey "^U" backward-kill-line
unsetopt auto_pushd

if (( ${+SSH_CLIENT} )); then
  ZSH_THEME_TERM_TAB_TITLE_IDLE="%m:%18<..<%~%<<"
  ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"
else # local shell
  ZSH_THEME_TERM_TAB_TITLE_IDLE="%18<..<%~%<<" #left truncated pwd
  ZSH_THEME_TERM_TITLE_IDLE="%~"
fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Appears at the beginning of (and during) of command execution
function preexec {
  emulate -L zsh
  setopt extended_glob
  local CMD=${1[(wr)^(*=*|sudo|ssh|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
  title "%m:$CMD" "%m:$CMD"
}
