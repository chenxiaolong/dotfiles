gdescribe() {
    local ref=${1:-HEAD}

    if [[ $(git tag | wc -l) -gt 0 ]]; then
        git describe --long | sed -E "s/^v//g;s/([^-]*-g)/r\1/;s/-/./g"
    else
        echo "r$(git rev-list --count "${ref}").$(git rev-parse --short "${ref}")"
    fi
}

garchive() {
    local ref=${1:-HEAD}

    local name
    name="$(basename "$(pwd)")-$(gdescribe "${ref}")"

    git archive \
        -o "${name}".tar.gz \
        --prefix="${name}/" \
        --format=tar.gz \
        -9 \
        -v \
        "${ref}"
}
