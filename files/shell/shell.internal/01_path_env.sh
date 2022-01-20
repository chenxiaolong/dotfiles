path_push_front() {
    if [[ -n "${PATH}" ]]; then
        export PATH=${1}:${PATH}
    else
        export PATH=${1}
    fi
}

path_push_back() {
    if [[ -n "${PATH}" ]]; then
        export PATH=${PATH}:${1}
    else
        export PATH=${1}
    fi
}

path_pop_front() {
    if [[ "${PATH}" =~ ':' ]]; then
        export PATH=${PATH#*:}
    else
        export PATH=
    fi
}

path_pop_back() {
    if [[ "${PATH}" =~ ':' ]]; then
        export PATH=${PATH%:*}
    else
        export PATH=
    fi
}

path_remove() {
    local remove="${1}"

    local result
    local p

    while read -r p; do
        if paths_same "${p}" "${remove}"; then
            continue
        fi
        result+="${p}"
        result+=:
    done < <(tr ':' '\n' <<< "${PATH}")

    export PATH=${result%:}
}
