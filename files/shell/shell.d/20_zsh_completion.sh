if is_shell zsh; then
    zmodload -i zsh/complist

    # Autocomplete on both sides if in the middle of a word
    setopt COMPLETE_IN_WORD

    # Move cursor to the end when completing in the middle of a word
    setopt ALWAYS_TO_END

    # Don't select first completion entry automatically
    unsetopt MENU_COMPLETE

    # Use menu completion
    setopt AUTO_MENU

    # Use menu selection
    zstyle ':completion:*' menu select

    # Autocomplete and then reattempt completion again (eg. on a directory)
    bindkey -M menuselect '^o' accept-and-infer-next-history

    # Set up matching specifications for tab completion. All specifications use
    # lowercase specifiers, allowing completions to modify what has already been
    # typed (eg. correcting uppercase to lowercase) to match a candidate.
    #
    # In plain English, the rules are:
    #
    # 1. Find candidates with the same prefix, but potentially differing in case
    # 2. Find candidates when the cursor is in the middle of the word, where the
    #    left side matches exactly, but the right side can be extended
    # 3. Find candidates where both the left and right sides of the cursor can
    #    be extended
    #
    # Thus, the least "fuzzy" matches are preferred. Note that all three rules
    # are separate. For example, `|BAR.` would not match `foobar.txt` because
    # rules 1 and 2 are not combined. In fact, later rules are only processed if
    # prior rules return no candidates (unless the rule is prefixed with `+`).
    #
    # The rules are explained in more detail below. For all of the examples, the
    # candidate being tested against is `foobar.txt` and `|` denotes where the
    # cursor position is when hitting the <tab> key.
    #
    # 1. Allow ASCII uppercase letters in the word to match lowercase letters in
    #    the candidates in the same position and vice versa.
    #
    #    Examples:
    #      - `FOOBAR|` - These both match because the left sides of the cursors
    #      - `FoObAr|`   match the candidate, ignoring case sensitivity.
    #
    # 2. Allow the empty string at the end of the word to match any characters
    #    at the end of the candidates. The candidates matched by this rule are
    #    a subset of the candidates matched by rule 3, but this rule does not
    #    allow extending the left side of the cursor. This causes same prefix
    #    candidates to be preferred in most cases.
    #
    #    Examples:
    #      - `bar.|`   - Does not match because `bar.` is implicitly anchored on
    #                    the left.
    #      - `ba|r.`   - Does not match for the same reason as the previous
    #                    example.
    #      - `foo|bar` - Matches because the left side matches and right side
    #                    can be extended.
    #      - `|bar.`   - Matches because both the left and right sides can be
    #                    extended. This is a special case because there's
    #                    prefix left of the cursor that must match exactly.
    #
    # 3. Allow the empty strings at the beginning and the end of the word to
    #    match any characters at the beginning and end of the candidates,
    #    respectively.
    #
    #    Examples:
    #      - `|bar.` - These all match because both the left and right sides can
    #      - `ba|r.`   be extended to match the candidate.
    #      - `bar.|`
    #
    # See: http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html#Completion-Matching-Control
    zstyle ':completion:*' matcher-list \
        'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
        'r:|=*' \
        'l:|=* r:|=*'

    # Show all user processes and change the visible columns
    zstyle ':completion:*:*:*:*:processes' command \
        'ps -u $USER -o pid,time,comm -w -w'
fi
