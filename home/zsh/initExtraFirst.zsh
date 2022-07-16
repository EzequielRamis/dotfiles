setopt nobanghist

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

autoload -Uz vcs_info

export GPG_TTY=$(tty)
