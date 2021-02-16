if is_os macOS; then
    alias_if_missing ls 'ls -G'
else
    alias_if_missing ls 'ls --color=auto'
fi
