-- https://github.com/chriskempson/base16-shell/blob/master/scripts/base16-tomorrow-night.sh
local M = {
    ansi = {
        '#1d1f21',
        '#cc6666',
        '#b5bd68',
        '#f0c674',
        '#81a2be',
        '#b294bb',
        '#8abeb7',
        '#c5c8c6',
    },
    brights = {
        '#969896',
        '#cc6666',
        '#b5bd68',
        '#f0c674',
        '#81a2be',
        '#b294bb',
        '#8abeb7',
        '#ffffff',
    },
    indexed = {
        [0x16] = '#de935f',
        [0x17] = '#a3685a',
        [0x18] = '#282a2e',
        [0x19] = '#373b41',
        [0x20] = '#b4b7b4',
        [0x21] = '#e0e0e0',
    },
    -- From base16-iterm2
    selection_bg = '#c7c9c6',
    selection_fg = '#413b37',
}

return M
