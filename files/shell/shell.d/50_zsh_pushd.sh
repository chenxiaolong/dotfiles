if is_shell zsh; then
    # Make `cd` push the previous directory onto the directory stack
    setopt AUTO_PUSHD

    # Deduplicate directory stack
    setopt PUSHD_IGNORE_DUPS
fi
