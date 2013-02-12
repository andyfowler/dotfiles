autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
# also some code from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gitfast/git-prompt.sh

if (( $+commands[git] ))
then
  git=$commands[git]
else
  git=/usr/bin/git
fi

__gitdir () {
  if [ -z "${1-}" ]; then
    if [ -n "${__git_dir-}" ]; then
      echo "$__git_dir"
    elif [ -n "${GIT_DIR-}" ]; then
      test -d "${GIT_DIR-}" || return 1
      echo "$GIT_DIR"
    elif [ -d .git ]; then
      echo .git
    else
      git rev-parse --git-dir 2>/dev/null
    fi
  elif [ -d "$1/.git" ]; then
    echo "$1/.git"
  else
    echo "$1"
  fi
}

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_status() {
  local g="$(__gitdir)"
  if [ ! -n "$g" ]; 
    then return 1
  fi;

  local unstaged=" "
  local staged=" "
  local untracked=" "

  git diff --no-ext-diff --ignore-submodules=dirty --quiet --exit-code || unstaged="*"

  if git rev-parse --quiet --verify HEAD >/dev/null; then
    git diff-index --cached --quiet HEAD -- || staged="✓"
  fi

  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
    untracked="?"
  fi
  
  local status_formatted="%{$FG[239]%}$untracked$staged%{$reset_color%}"

  if [[ "$unstaged" == " " ]]
  then
    echo "%{$fg[green]%}$(git_prompt_info)%{$reset_color%} $status_formatted"
  else
    echo "%{$fg[red]%}$(git_prompt_info)%{$reset_color%} $status_formatted"
  fi
}

git_prompt_info () {
  ref=$($git symbolic-ref HEAD 2>/dev/null) || return
  echo "${ref#refs/heads/}"
}

# key here is %2~ which replaces home with tilde, and shows at most 4 paths
directory_name() {
  echo "%{$FG[039]%}%2~%{$reset_color%}"
}

host_name() {
  echo "%{$FG[153]%}%m%{$reset_color%}"
}

export PROMPT=$'\n$(host_name) $(directory_name) $(git_status) \n› '
set_prompt () {
  export RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
