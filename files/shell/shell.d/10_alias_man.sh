man() {
    # https://wiki.archlinux.org/title/Color_output_in_console#Using_less
    MANPAGER='less -R --use-color -Dd+b -Dug' \
    MANROFFOPT='-P -c' \
    command man "${@}"
}
