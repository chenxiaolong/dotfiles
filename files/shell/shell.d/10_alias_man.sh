man() {
    local pager roffopt

    if command -v nvim >/dev/null; then
        pager='nvim +Man!'
    else
        # https://wiki.archlinux.org/title/Color_output_in_console#Using_less
        pager='less -R --use-color -Dd+b -Dug'
        roffopt='-P -c'
    fi

    MANPAGER="${pager}" \
    MANROFFOPT="${roffopt}" \
    command man "${@}"
}
