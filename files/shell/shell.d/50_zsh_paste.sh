if is_shell zsh; then
    # Enable recognition of bracketed paste sequences for safe multiline pasting
    autoload -Uz bracketed-paste-magic
    zle -N bracketed-paste bracketed-paste-magic

    # Automatically escape special characters when pasting URLs
    autoload -Uz url-quote-magic
    zle -N self-insert url-quote-magic
fi
