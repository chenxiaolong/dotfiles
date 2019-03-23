# Avoid using glyphs overridden by the Apple Colored Emoji font
# https://gitlab.com/gnachman/iterm2/issues/3384
# The replacement glyphs are used by other oh-my-zsh themes anyway
ZSH_THEME_GIT_PROMPT_MODIFIED=${ZSH_THEME_GIT_PROMPT_MODIFIED:s/⚡/✹}
ZSH_THEME_GIT_PROMPT_UNMERGED=${ZSH_THEME_GIT_PROMPT_UNMERGED:s/♒/═}
