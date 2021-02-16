if is_shell zsh; then
    # Use LS_COLORS for tab completion if possible. If unset, this falls back
    # to zsh's defaults.
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi
