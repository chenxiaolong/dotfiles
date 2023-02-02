if is_os Linux; then
    if [[ -z "${__distro}" ]]; then
        __distro="$(source /etc/os-release && echo "${ID}")"
    fi

    is_distro() {
        [[ "${__distro}" == "${1}" ]]
    }
fi
