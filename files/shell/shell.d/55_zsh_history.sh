if is_shell zsh; then
    # Do not share history
    setopt NO_SHARE_HISTORY

    # Save the time and duration
    setopt EXTENDED_HISTORY

    # Update history file incrementally. oh-my-zsh no longer does this by
    # default as of: https://github.com/ohmyzsh/ohmyzsh/pull/8048
    setopt inc_append_history

    # Save more history
    HISTSIZE=50000
    SAVEHIST=50000
fi
