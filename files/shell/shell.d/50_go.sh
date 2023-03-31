if command -v go >/dev/null; then
    goclean() {
        local p

        for p in "${@}"; do
            p=$(readlink -f "${p}")
            GOPATH="${p}" go clean -modcache
            find "${p}" -empty -delete
        done
    }
fi
