if command -v sccache >/dev/null; then
    export RUSTC_WRAPPER=sccache
fi
