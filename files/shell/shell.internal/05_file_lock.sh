flock_fd() {
    local fd=${1}

    if command -v flock &>/dev/null; then
        flock "${fd}"
    else
        python -c 'import fcntl, sys; fcntl.flock(int(sys.argv[1]), fcntl.LOCK_EX)' "${fd}"
    fi
}
