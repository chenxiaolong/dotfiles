if is_os WSL \
        && command -v npiperelay.exe &>/dev/null \
        && command -v socat &>/dev/null; then
    pipe_windows_socket() {
        local win_socket=${1}
        local lin_socket=${2}

        if ! socat OPEN:/dev/null UNIX-CONNECT:"${lin_socket}" &>/dev/null; then
            rm -f "${lin_socket}"
            (
                # Switch to helper script directory and also use a helper script
                # for npiperelay so that socat never has a chance to see a space
                # in the EXEC: argument.
                script_file=${BASH_SOURCE[0]:-${(%):-%x}}
                script_dir=${script_file%.sh}
                export WIN_SOCKET=${win_socket}

                if cd "${script_dir}"; then
                    setsid socat \
                        UNIX-LISTEN:"${lin_socket}",fork \
                        EXEC:'./npiperelay_helper.sh',nofork &
                fi
            )
        fi
    }

    export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock

    pipe_windows_socket \
        //./pipe/openssh-ssh-agent \
        "${SSH_AUTH_SOCK}"

    unset -f pipe_windows_socket
fi
