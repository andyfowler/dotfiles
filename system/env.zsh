if which atom &> /dev/null
then
	export EDITOR='atom'
else
	export EDITOR='vim'
fi

# these are for mac / BSD ls
# see also aliases.zsh for GNU ls
export CLICOLOR=1
# export LSCOLORS=exfxcxdxbxegedabagacad # this is currently the default, someday i'll twek it

if [[ -a ~/.aws.ini ]]; then
	export AWS_CONFIG_FILE=~/.aws.ini
fi

export MYSQL_PS1="[$(hostname -s):\\d]> "
