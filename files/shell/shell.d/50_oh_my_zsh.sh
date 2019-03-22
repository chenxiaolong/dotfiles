if is_shell zsh; then
    # Two lines
    #ZSH_THEME="kphoen" # Very useful

    # Minimal themes
    #ZSH_THEME="agnoster"
    #ZSH_THEME="lukerandall" # 2 dirs shown, like Ubuntu
    #ZSH_THEME="nanotech" # Space saving, but no return status
    ZSH_THEME="wedisagree" # Single line, 1 dir, pretty icons
    #ZSH_THEME=dst # 2 line, looks nice, but long
    #ZSH_THEME=jnrowe # a little too long
    #ZSH_THEME=jonathan # awesome
    #ZSH_THEME=sporty_256 # awesome colors
    #ZSH_THEME="powerlevel9k/powerlevel9k"

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
        git
        #command-not-found
        mercurial
        cp
        git-extras
        sudo
        gradle
        python
        gitignore
        #vi-mode
        #kubectl
    )

    if is_os Linux; then
        plugins+=(kate systemd)

        if is_distro Arch; then
            plugins+=(archlinux)
        elif is_distro Fedora; then
            plugins+=(yum)
        fi
    fi

    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
fi
