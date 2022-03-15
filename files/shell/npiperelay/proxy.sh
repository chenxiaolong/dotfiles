set -euo pipefail

source "${DOTFILES}"/files/shell/shell.internal/02_os.sh
source "${DOTFILES}"/files/shell/shell.internal/05_file_lock.sh
source "${DOTFILES}"/files/shell/npiperelay/init.sh

export SSH_AUTH_SOCK=${HOME}/.ssh/agent.sock

# Proxy through a native Windows process so that msys's cygwin exec handling
# doesn't cause msys's executables to use git's shared libraries
msys_run() {
    /C/msys64/msys2_shell.cmd -here -mingw64 -defterm -no-start -use-full-path -c \
        "$(printf '%q ' "${@}")"
}

setsid() {
    msys_run setsid "${@}"
}

socat() {
    msys_run socat "${@}"
}

pipe_windows_socket \
    //./pipe/openssh-ssh-agent \
    "${SSH_AUTH_SOCK}"

exec ssh "${@}"
