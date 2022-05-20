PROMPT=$'\n'"%BΓ,%b %(4~|%-1~/.../%2~|%~)"$'\n'"%Bλ.%b "

bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[5~' history-beginning-search-backward
bindkey '^[[6~' history-beginning-search-forward

bindkey '^[[1;5D'  backward-word
bindkey '^[[1;5C'  forward-word
bindkey '^[[1;5B'  backward-word
bindkey '^[[1;5A'  forward-word
bindkey '^H'       backward-kill-word

eval "$(direnv hook zsh)"
