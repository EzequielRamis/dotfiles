zstyle ':vcs_info:git*' formats "%b"
typeset -g -A key

key[Ctrl-Left]=$'^[[1;5D'
key[Ctrl-Right]=$'^[[1;5C'
key[Ctrl-Delete]=$'^[[3;5~'
key[Ctrl-Backspace]=$'^H'

[[ -n "${key[Up]}"             ]] && bindkey -- "${key[Up]}"              up-line-or-beginning-search
[[ -n "${key[Down]}"           ]] && bindkey -- "${key[Down]}"            down-line-or-beginning-search
[[ -n "${key[Delete]}"         ]] && bindkey -- "${key[Delete]}"          delete-char
[[ -n "${key[Ctrl-Left]}"      ]] && bindkey -- "${key[Ctrl-Left]}"       backward-word
[[ -n "${key[Ctrl-Right]}"     ]] && bindkey -- "${key[Ctrl-Right]}"      forward-word
[[ -n "${key[Ctrl-Delete]}"    ]] && bindkey -- "${key[Ctrl-Delete]}"     kill-word
[[ -n "${key[Ctrl-Backspace]}" ]] && bindkey -- "${key[Ctrl-Backspace]}"  backward-kill-word

if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

precmd () {
    vcs_info

    # from https://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
    local zero='%([BSUbfksu]|([FK]|){*})'

    local CANDY=""
    local RANDY=""
    [[ ! -z ${IN_NIX_SHELL} ]]    && CANDY+=" ❄" # check inserting the emoji again if in kitty does not work
    [[ ! -z ${vcs_info_msg_0_} ]] && RANDY+="${vcs_info_msg_0_} שׂ"

    local PROMPTL="%BΓ,%b %(4~|%-1~/.../%2~|%~)$CANDY"
    local PROMPTR=$RANDY

    local PROMPTW # White space
    (( PROMPTW = ${COLUMNS} - ${#${(S%%)PROMPTL//$~zero/}} - ${#${(S%%)PROMPTR//$~zero/}} ))

    PROMPT=$'\n'$PROMPTL${(pl:PROMPTW:: :)}$PROMPTR$'\n'"%Bλ.%b "
}

eval "$(direnv hook zsh)"

export DIRENV_LOG_FORMAT=
