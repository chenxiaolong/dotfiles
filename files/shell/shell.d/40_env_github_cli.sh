if command -v gh &>/dev/null && (is_shell zsh || is_shell bash); then
    eval "$(gh completion -s "${__config_current_shell}")"
fi
