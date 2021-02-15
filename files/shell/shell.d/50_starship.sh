if command -v starship >/dev/null && (is_shell bash || is_shell zsh); then
    eval "$(starship init "${__config_current_shell}")"

    # Hacky way to append "(WSL)" to the hostname until starship supports
    # displaying multiple environment variables
    # https://github.com/starship/starship/issues/1194
    if is_os WSL; then
        starship_append_wsl() {
            local hostname=$(hostname)
            hostname=${hostname%.*}
            PROMPT=${PROMPT/${hostname}/${hostname}(WSL)}
        }

        precmd_functions+=(starship_append_wsl)
    fi
fi
