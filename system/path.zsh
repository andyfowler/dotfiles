export PATH="$HOME/.composer/vendor/bin:/usr/local/share/npm/bin:/usr/local/opt/ruby/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$HOME/source/bin:$PATH"
if [[ -d /usr/local/opt/php56/bin ]]; # from homebrew, but brew --prefix is slow
then
  export PATH="/usr/local/opt/php56/bin:$PATH"
fi

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export GOPATH="$HOME/source"
