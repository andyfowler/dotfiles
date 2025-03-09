export PATH="$HOME/.composer/vendor/bin:/usr/local/share/npm/bin:/usr/local/opt/ruby/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$HOME/source/bin:$PATH"
if [[ -d $HOME/.duckdb/cli/latest ]]; 
then
  export PATH="$HOME/.duckdb/cli/latest:$PATH"
fi

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export GOPATH="$HOME/source"
