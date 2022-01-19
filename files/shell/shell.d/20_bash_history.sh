if is_shell bash && [[ -z "${HISTCONTROL}" ]]; then
    HISTCONTROL=ignoredups
fi
