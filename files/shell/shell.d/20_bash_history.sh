if is_shell bash; then
    if [[ -z "${HISTCONTROL}" ]]; then
        HISTCONTROL=ignoredups
    fi

    shopt -s histverify
fi
