if command -v starship >/dev/null && (is_shell bash || is_shell zsh); then
    eval "$(starship init "${__config_current_shell}")"

    if is_os WSL; then
        starship_wsl() {
            # Hacky way to append "(WSL)" to the hostname until starship
            # supports displaying multiple environment variables
            # https://github.com/starship/starship/issues/1194
            local hostname=$(hostname)
            hostname=${hostname%.*}
            PS1=${PS1/${hostname}/${hostname}(WSL:${WSL_DISTRO_NAME})}

            # OSC 9;9
            printf "\e]9;9;\"%s\"\e\\" "$(wslpath -w "$(pwd)")"
        }

        if is_shell zsh; then
            precmd_functions+=(starship_wsl)
        else
            starship_prompt_command=${PROMPT_COMMAND}
            starship_prompt_wrap() {
                eval "${starship_prompt_command}"
                starship_wsl
            }
            PROMPT_COMMAND=starship_prompt_wrap
        fi
    fi
fi
