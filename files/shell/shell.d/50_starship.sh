if starship_path=$(command -v starship) && (is_shell bash || is_shell zsh); then
    eval "$(starship init "${__config_current_shell}")"

    if is_os WSL; then
        starship_wsl_hostname_replace() {
            # Hacky way to append "(WSL)" to the hostname until starship
            # supports displaying multiple environment variables
            # https://github.com/starship/starship/issues/1194
            local hostname=$(hostname)
            hostname=${hostname%.*}
            
            literal_replace "${hostname}" "${hostname}(WSL:${WSL_DISTRO_NAME})"
        }

        starship_wsl_osc99() {
            # OSC 9;9
            printf "\e]9;9;\"%s\"\e\\" "$(wslpath -w "$(pwd)")"
        }

        if is_shell zsh; then
            starship_prompt_wrap() {
                starship_wsl_osc99
                "${starship_path}" "${@}" | starship_wsl_hostname_replace
            }
            PROMPT=$(literal_replace "${starship_path}" starship_prompt_wrap <<< "${PROMPT}")
        else
            starship_prompt_command=${PROMPT_COMMAND}
            starship_prompt_wrap() {
                eval "${starship_prompt_command}"
                PS1=$(starship_wsl_hostname_replace <<< "${PS1}")
                starship_wsl_osc99
            }
            PROMPT_COMMAND=starship_prompt_wrap
        fi
    fi
fi
