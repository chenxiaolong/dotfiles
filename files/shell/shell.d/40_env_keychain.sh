if command -v keychain &>/dev/null \
        && (is_os WSL || (! is_os macOS \
                && [[ "${XDG_CURRENT_DESKTOP}" != GNOME ]])); then
    eval $(keychain -q --eval)
fi
