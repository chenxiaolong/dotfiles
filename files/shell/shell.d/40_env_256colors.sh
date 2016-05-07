# Taken from Fedora wiki

# Uncomment this if you want remote xterms connecting
# to this system, to be sent 256 colors.  Note that
# local xterms, ssh'ing to localhost are considered
# remote in this context, but in that case, $TERM should
# have already been set to 256 color capable.
#
# SEND_256_COLORS_TO_REMOTE=1

# Terminals with any of the following set, support 256 colors (and are local)
local256="${COLORTERM}${XTERM_VERSION}${ROXTERM_ID}${KONSOLE_DBUS_SESSION}"

if test "${local256}" || test "${SEND_256_COLORS_TO_REMOTE}"; then
    case "${TERM}" in
        xterm) TERM=xterm-256color;;
        screen) TERM=screen-256color;;
        Eterm) TERM=Eterm-256color;;
    esac
    export TERM

    if [ ! -z "${TERMCAP}" ] && [ "${TERM}" = "screen-256color" ]; then
        TERMCAP="${TERMCAP//Co#8/Co#256}"
        export TERMCAP
    fi
fi

unset local256
