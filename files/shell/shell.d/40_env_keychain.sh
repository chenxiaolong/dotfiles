if ! is_os macOS \
        && [[ "${XDG_CURRENT_DESKTOP}" != GNOME ]] \
        && command -v keychain &>/dev/null; then
    eval $(keychain -q --eval)
fi
