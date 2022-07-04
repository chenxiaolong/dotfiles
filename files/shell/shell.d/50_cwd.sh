# If this is Konsole, then don't emit any OSC7 sequences. It specifically breaks
# konsolepart inside dolphin when switching directories.
if [[ -n "${KONSOLE_VERSION}" ]]; then
    disable_wezterm_osc7() {
        if [[ "${#precmd_functions[@]}" -gt 0 ]]; then
            local temp=() item
            for item in "${precmd_functions[@]}"; do
                if [[ ${item} != __wezterm_osc7 ]]; then
                    temp+=("${item}")
                fi
            done
            precmd_functions=("${temp[@]}")
        fi
    }

    disable_wezterm_osc7
    unset -f disable_wezterm_osc7

    return
fi

# No need to set up OSC 7 ourselves if /etc/profile.d/wezterm.sh is doing it.
if ! in_array __wezterm_osc7 "${precmd_functions[@]}"; then
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
        add-zsh-hook -Uz precmd "${__osc_func}"
    fi
fi
