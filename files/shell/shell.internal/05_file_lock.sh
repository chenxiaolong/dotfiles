flock_fd() {
    local fd=${1}

    if command -v flock &>/dev/null; then
        flock "${fd}"
    elif command -v perl &>/dev/null; then
        perl -e 'use Fcntl qw(:flock); open(my $fh, "<&=", $ARGV[0]); flock($fh, LOCK_EX) || die "flock: $!";' "${fd}"
    else
        python -c 'import fcntl, sys; fcntl.flock(int(sys.argv[1]), fcntl.LOCK_EX)' "${fd}"
    fi
}
