export PATH="$HOME/.composer/vendor/bin:/usr/local/share/npm/bin:/usr/local/opt/ruby/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$HOME/source/bin:$PATH"
if which brew &> /dev/null
then
  export PATH="$(brew --prefix php56)/bin:$PATH"
fi

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export GOPATH="$HOME/source"
