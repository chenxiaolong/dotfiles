if command -v diff >/dev/null; then
    alias_if_missing diff 'diff --color=auto'
fi
