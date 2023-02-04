if is_os Linux; then
    if [[ -z "${__distro}" ]]; then
        if [[ -n "${TERMUX_VERSION}" ]]; then
            __distro=termux
        else
            __distro="$(source /etc/os-release && echo "${ID}")"
        fi
    fi

    is_distro() {
        [[ "${__distro}" == "${1}" ]]
    }
fi
