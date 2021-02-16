if is_shell zsh; then
    # Use emacs keybindings
    bindkey -e

    # ^x^e for editing the current command in $EDITOR (like in bash)
    autoload -Uz edit-command-line
    zle -N edit-command-line
    bindkey '\C-x\C-e' edit-command-line

    # Move by one word
    bindkey '^[[1;5D' backward-word # Ctrl-left
    bindkey '^[[1;5C' forward-word  # Ctrl-right

    # Switch to application mode to ensure that the terminfo values are
    # applicable. See: http://zsh.sourceforge.net/FAQ/zshfaq03.html#l25
    if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        zle-line-init() {
            echoti smkx
        }
        zle-line-finish() {
            echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
    fi

    bind_terminfo_key() {
        local sequence=${terminfo[${1}]} widget=${2}

        if (( ${+sequence} )); then
            bindkey "${sequence}" "${widget}"
        fi
    }

    # zsh handles arrow keys natively now, but not home/end/delete
    bind_terminfo_key kich1 overwrite-mode    # Insert
    bind_terminfo_key kdch1 delete-char       # Delete
    bind_terminfo_key khome beginning-of-line # Home
    bind_terminfo_key kend  end-of-line       # End

    # Tab through completion items backwards
    bind_terminfo_key kcbt  reverse-menu-complete # Shift-tab

    unfunction bind_terminfo_key
fi
