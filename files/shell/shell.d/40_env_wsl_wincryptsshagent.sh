if is_os WSL \
        && (command -v WinCryptSSHAgent.exe || command -v wincrypt-sshagent.exe) &>/dev/null \
        && command -v socat &>/dev/null; then
    export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock

    (
        exec {lock_fd}> "${SSH_AUTH_SOCK}.lock"
        flock_fd "${lock_fd}"

        if ! socat OPEN:/dev/null UNIX-CONNECT:"${SSH_AUTH_SOCK}" 2>/dev/null; then
            rm -f "${SSH_AUTH_SOCK}"

            # socat should not inherit the lock file's file descriptor
            setsid socat \
                UNIX-LISTEN:"${SSH_AUTH_SOCK}",fork \
                SOCKET-CONNECT:40:0:x0000x33332222x02000000x00000000 \
                {lock_fd}>&- \
                &
        fi
    )
fi
