typeset -g smart_command_history__last_line

smart_command_history__zshaddhistory() {
    smart_command_history__last_line="${1%%$'\n'}"
    return 2
}

smart_command_history__precmd() {
    local last_status="$?"
    local line="$smart_command_history__last_line"

    if [[ -z "$line" ]]; then
        return
    fi

    smart_command_history__last_line=''

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

zshaddhistory_functions+=( smart_command_history__zshaddhistory )
precmd_functions+=( smart_command_history__precmd )
