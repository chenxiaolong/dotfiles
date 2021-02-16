if is_shell zsh; then
    if [[ -z "${HISTFILE}" ]]; then
        HISTFILE=${HOME}/.zsh_history
    fi

    # Show entire history by default
    history() {
        if [[ "${#}" -eq 0 ]]; then
            set -- 1
        fi
        builtin history "${@}"
    }

    # Do not share history
    setopt NO_SHARE_HISTORY

    # Save the time and duration
    setopt EXTENDED_HISTORY

    # Update history file incrementally when command is run
    setopt INC_APPEND_HISTORY

    # Avoid inserting duplicate commands into history
    setopt HIST_IGNORE_DUPS

    # Avoid inserting commands beginning with a space
    setopt HIST_IGNORE_SPACE

    # Allow command to be edited before running when searching the history
    setopt HIST_VERIFY

    # Delete duplicates first when exceeding maximum size
    setopt HIST_EXPIRE_DUPS_FIRST

    # Save more history
    HISTSIZE=50000
    SAVEHIST=50000
fi
