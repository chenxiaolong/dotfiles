__urlencode() {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case "${c}" in
            %) printf '%%%02X' "'${c}" ;;
            *) printf "%s" "${c}" ;;
        esac
    done
}

__osc7() {
    printf '\e]7;file://%s%s\e\\' "${HOSTNAME}" "$(__urlencode "${PWD}")"
}

__wsl_osc99() {
    printf '\e]9;9;"%s"\e\\' "$(wslpath -w "${PWD}")"
}

if is_os WSL && [[ "${TERM_PROGRAM}" != WezTerm ]]; then
    __osc_func=__wsl_osc99
else
    __osc_func=__osc7
fi

if is_shell bash; then
    declare -a PROMPT_COMMAND
    PROMPT_COMMAND+=("${__osc_func}")
elif is_shell zsh; then
    autoload -Uz add-zsh-hook
    add-zsh-hook -Uz chpwd "${__osc_func}"
fi
