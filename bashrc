# System-wide .bashrc file for interactive bash(1) shells.
if [ -z "$PS1" ]; then
   return
fi


if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
	PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
fi



# Make bash check its window size after a process completes
shopt -s checkwinsize

export PATH=/opt/local/share/doc/ZendFramework/bin/:/opt/local/apache2/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH


export ZEND_TOOL_INCLUDE_PATH="/opt/local/lib/ZendFramework/library"

# for textmate svn
export LC_CTYPE=en_US.UTF-8

export HISTCONTROL=ignoreboth

export EDITOR='mate_wait'
export LESSEDIT='mate -l %lm %f'

export CLICOLOR=1
export LSCOLORS=dxfxcxdxbxegedabagacad

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

alias s="sudo su -"

alias ll="ls -al"

alias ssh="ssh -A"

alias pu="phpunit"
alias pus="phpunit --stop-on-failure"
export nut="/Users/afowler/Sites/nutshell"