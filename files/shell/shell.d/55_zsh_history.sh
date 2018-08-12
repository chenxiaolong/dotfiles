if is_shell zsh; then
    # Do not share history
    setopt NO_SHARE_HISTORY

    # Save the time and duration
    setopt EXTENDED_HISTORY

    # Save more history
    HISTSIZE=50000
    SAVEHIST=50000
fi
