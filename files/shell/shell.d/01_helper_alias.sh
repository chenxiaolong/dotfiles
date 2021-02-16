alias_if_missing() {
    local name=${1} target=${2}

    if ! alias | grep -q "^${name}="; then
        alias "${name}=${target}"
    fi
}
