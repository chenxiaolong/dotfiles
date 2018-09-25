if command -v kubectl &>/dev/null; then
    alias k='kubectl'

    kns_usage() {
        cat << EOF
Usage: kns <cluster> [<kubectl arg> ...]

The <cluster> argument must be provided and is shorthand for

    --kubeconfig ~/.kube/config.<cluster>

EOF
    }

    kns() {
        if [[ "${1}" == -* || "${1}" == */* ]]; then
            kns_usage >&2
            return 1
        fi

        local kubeconfig=${HOME}/.kube/config.${1}

        if [[ ! -f "${kubeconfig}" ]]; then
            echo "${kubeconfig} does not exist" >&1
            return 1
        fi

        shift
        kubectl --kubeconfig="${kubeconfig}" "${@}"
    }
fi
