if is_shell zsh; then
    setopt NO_HASH_DIRS
    setopt NO_HASH_CMDS
    zstyle ":completion:*:commands" rehash 1
fi
