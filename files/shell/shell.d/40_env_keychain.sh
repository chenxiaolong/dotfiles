if command -v keychain &>/dev/null \
        && ! is_os WSL \
        && ! is_os macOS \
        && [[ -z "${SSH_AUTH_SOCK}" ]]; then
    eval "$(keychain -q --eval)"
fi
