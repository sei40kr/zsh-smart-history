typeset -g __smart_history_last_line

__smart_history_zshaddhistory() {
    __smart_history_last_line="${1%%$'\n'}"
    return 2
}

__smart_history_precmd() {
    local last_status="$?"
    local line="$__smart_history_last_line"

    if [[ -z "$line" ]]; then
        return
    fi

    __smart_history_last_line=''

    if [[ "$last_status" != 0 && "$last_status" != 130 ]]; then
        return
    fi

    if [[ -o HIST_IGNORE_SPACE && "$line" = ' '* ]]; then
        return
    fi

    if [[ -o HIST_REDUCE_BLANKS ]]; then
        line="${(z)line}"
    fi

    print -sr -- "$line"
}

zshaddhistory_functions+=( __smart_history_zshaddhistory )
precmd_functions+=( __smart_history_precmd )
