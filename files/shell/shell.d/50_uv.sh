# Slightly more correct variation of:
# https://github.com/astral-sh/uv/issues/8432#issuecomment-2605216865

if is_shell zsh && command -v uv >/dev/null; then
    _uv_run() {
        local positional=(${words:#-*})

        if [[ $positional[2] != run || $words[CURRENT] == -* ]]; then
            _uv "$@"
            return
        fi

        local venv_binaries=(${(@ps:\0:)"$(_call_program files \
            find .venv/bin \
            -mindepth 1 -maxdepth 1 \
            -printf '%f\\0' \
            2>/dev/null)"})

        _alternative \
            'files:filename:_files' \
            "binaries:venv binary:(($venv_binaries))"
    }

    compdef _uv_run uv
fi
