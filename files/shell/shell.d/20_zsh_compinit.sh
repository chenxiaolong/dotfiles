if is_shell zsh; then
    # Additional zsh completions
    fpath+=("${__config_dotfiles_dir}/submodules/zsh-completions/src")

    # Enable support for zsh and bash completion
    autoload -Uz compinit bashcompinit
    compinit
    bashcompinit

    # Load bash completions for certain commands that don't have zsh completion
    bash_completions=(
        distrobox
    )

    for p in "${bash_completions[@]}"; do
        if [[ -f /usr/share/bash-completion/completions/"${p}" ]]; then
            source /usr/share/bash-completion/completions/"${p}"
        fi
    done

    unset p bash_completions
fi
