if is_shell zsh; then
    # Disable all theming because we use the starship prompt
    ZSH_THEME=

    # Set to this to use case-sensitive completion
    # CASE_SENSITIVE="true"

    # Comment this out to disable bi-weekly auto-update checks
    DISABLE_AUTO_UPDATE="true"

    # Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
    # export UPDATE_ZSH_DAYS=13
    export UPDATE_ZSH_DAYS=3

    # Uncomment following line if you want to disable colors in ls
    # DISABLE_LS_COLORS="true"

    # Uncomment following line if you want to disable autosetting terminal title.
    # DISABLE_AUTO_TITLE="true"

    # Uncomment following line if you want red dots to be displayed while waiting for completion
    COMPLETION_WAITING_DOTS="true"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    plugins=(
        gradle
    )

    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
fi
