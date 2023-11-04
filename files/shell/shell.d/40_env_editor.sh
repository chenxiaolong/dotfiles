if command -v hx >/dev/null; then
    export EDITOR=hx
elif command -v nvim >/dev/null; then
    export EDITOR=nvim
elif command -v vim >/dev/null; then
    export EDITOR=vim
fi
