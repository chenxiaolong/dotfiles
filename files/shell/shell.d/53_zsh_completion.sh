if is_shell zsh; then
    autoload -Uz compinit
    # Use oh-my-zsh's compdump file
    compinit -d "${ZSH_COMPDUMP}"
fi
