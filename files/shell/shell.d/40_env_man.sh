if command -v nvim >/dev/null; then
    export MANPAGER='nvim +Man!'
    export MANWIDTH=999
else
    # https://wiki.archlinux.org/title/Color_output_in_console#Using_less
    export MANPAGER='less -R --use-color -Dd+b -Dug'
    export MANROFFOPT='-P -c'
fi
