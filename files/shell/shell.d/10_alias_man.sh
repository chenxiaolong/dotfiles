if command -v bat >/dev/null && [[ -z "${MANPAGER}" ]]; then
    # base16 theme doesn't colorize much in man pages
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
    man() {
        # From website:
        # http://www.cyberciti.biz/faq/linux-unix-colored-man-pages-with-less-command/
        # https://wiki.archlinux.org/index.php/Man_Page

        LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;31m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;32m")" \
        man "${@}"
    }
fi
