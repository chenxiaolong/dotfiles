if command -v starship >/dev/null && (is_shell bash || is_shell zsh); then
    eval "$(starship init "${__config_current_shell}")"
fi
