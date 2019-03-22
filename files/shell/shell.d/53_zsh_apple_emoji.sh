# Avoid using glyphs overridden by the Apple Colored Emoji font
# https://gitlab.com/gnachman/iterm2/issues/3384
if is_os macOS && [[ -n "${ITERM_PROFILE}" ]]; then
    ZSH_THEME_GIT_PROMPT_MODIFIED=${ZSH_THEME_GIT_PROMPT_MODIFIED:s/⚡/✹}
    ZSH_THEME_GIT_PROMPT_UNMERGED=${ZSH_THEME_GIT_PROMPT_UNMERGED:s/♒/═}
fi
