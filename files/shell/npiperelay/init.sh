pipe_windows_socket() {
    local win_named_pipe=${1}
    local unix_socket=${2}
    local exec_opts=,nofork

    if is_os Windows; then
        exec_opts=,pipes
    fi

    (
        exec {lock_fd}> "${unix_socket}.lock"
        flock_fd "${lock_fd}"

        if ! socat OPEN:/dev/null UNIX-CONNECT:"${unix_socket}" 2>/dev/null; then
            rm -f "${unix_socket}"

            # Switch to helper script directory and also use a helper script
            # for npiperelay so that socat never has a chance to see a space
            # in the EXEC: argument.
            script_file=${BASH_SOURCE[0]:-${(%):-%x}}
            script_dir=$(dirname "${script_file}")
            export WIN_NAMED_PIPE=${win_named_pipe}

            if cd "${script_dir}"; then
                # socat should not inherit the lock file's file descriptor
                setsid socat \
                    UNIX-LISTEN:"${unix_socket}",fork \
                    EXEC:'sh helper.sh'"${exec_opts}" \
                    {lock_fd}>&- \
                    &
            fi
        fi
    )
}
