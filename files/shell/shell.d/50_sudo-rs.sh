if command -v sudo-rs >/dev/null; then
    alias_if_missing sudo sudo-rs

    if is_shell zsh; then
        compdef _sudo sudo-rs
    elif is_shell bash; then
        $(_completion_loader sudo; complete -p sudo)-rs
    fi
fi
