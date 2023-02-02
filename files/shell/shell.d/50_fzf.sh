if command -v fzf >/dev/null; then
    if is_os Linux; then
        if is_distro fedora; then
            source /usr/share/fzf/shell/key-bindings."${__config_current_shell}"
        elif is_distro arch; then
            source /usr/share/fzf/key-bindings."${__config_current_shell}"
        elif is_distro ubuntu; then
            source /usr/share/doc/fzf/examples/key-bindings."${__config_current_shell}"
        fi
    fi
fi
