paths=(
    /usr/lib/ccache/bin
    /usr/local/opt/ccache/libexec
)

for p in "${paths[@]}"; do
    if [[ -d "${p}" ]]; then
        path_push_front "${p}"
    fi
done

unset p

export CCACHE_NLEVELS=4
