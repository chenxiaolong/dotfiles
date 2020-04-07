if is_shell zsh; then
    # Modify wedisagree theme this way so we don't have to fork the whole thing
    prepend_hostname() {
        local hostname_text=%m
        if is_os WSL; then
            hostname_text+='(WSL)'
        fi
        PROMPT="%{\${fg[yellow]}%}[${hostname_text}]%{\${reset_color}%}${PROMPT}"
    }

    prepend_hostname
    unset -f prepend_hostname
fi
