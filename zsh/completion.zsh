# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

if [[ -a "/usr/local/bin/aws_zsh_completer.sh" ]]; then
	source /usr/local/bin/aws_zsh_completer.sh
fi
