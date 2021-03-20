if is_os WSL \
        && command -v npiperelay.exe &>/dev/null \
        && command -v socat &>/dev/null \
        && command -v ss &>/dev/null; then
    export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock

    if ! ss -xl | grep -qF "${SSH_AUTH_SOCK}"; then
        rm -f "${SSH_AUTH_SOCK}"
        (
            setsid socat \
                UNIX-LISTEN:"${SSH_AUTH_SOCK}",fork \
                EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &
        ) #&>/dev/null
    fi
fi
