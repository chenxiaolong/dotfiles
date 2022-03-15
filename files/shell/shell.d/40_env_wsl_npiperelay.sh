if is_os WSL \
        && command -v npiperelay.exe &>/dev/null \
        && command -v socat &>/dev/null; then
    source "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")/../npiperelay/init.sh"

    export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock

    pipe_windows_socket \
        //./pipe/openssh-ssh-agent \
        "${SSH_AUTH_SOCK}"

    unset -f pipe_windows_socket
fi
