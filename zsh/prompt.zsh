autoload -U promptinit && promptinit
prompt pure

## override prompt's dark grey hostname and remove my username — https://github.com/sindresorhus/pure/issues/126

# show username@host if logged in through SSH
[[ "$SSH_CONNECTION" != '' ]] && prompt_pure_username=' %F{117}%m%f'

# show username@host if root, with username in white
[[ $UID -eq 0 ]] && prompt_pure_username=' %F{white}%n%f%F{242}@%F{117}%m%f'