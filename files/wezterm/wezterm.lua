local wezterm = require('wezterm')
local base16 = require('base16')
local tab_bar = require('tab_bar')

local colors = {
    ansi = base16.ansi,
    brights = base16.brights,
    indexed = base16.indexed,
    selection_bg = base16.selection_bg,
    selection_fg = base16.selection_fg,
    -- Same as tmux
    scrollbar_thumb = '#999999',
    split = '#999999',
    -- Tabs
    tab_bar = tab_bar.tab_bar,
}

colors.background = colors.ansi[1]
colors.foreground = colors.ansi[8]
colors.cursor_border = colors.foreground
colors.cursor_bg = colors.foreground
colors.cursor_fg = colors.background

wezterm.on('format-tab-title', tab_bar.format_tab_title)
wezterm.on('update-right-status', tab_bar.update_right_status)

-- Reduced font weight across the board
local fira_light = wezterm.font('Fira Code', {weight = 'Light'})
local fira_medium = wezterm.font('Fira Code', {weight = 'Medium'})

local options = {
    colors = colors,
    font = fira_light,
    font_rules = {
        {
            intensity = 'Bold',
            font = fira_medium,
        },
        -- Disable italics
        {
            italic = true,
            font = fira_light,
        },
    },
    font_size = 9,
    enable_wayland = true,
    enable_scroll_bar = true,
    scrollback_lines = 50000,
    tab_max_width = 24,
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    options.default_prog = {'pwsh.exe'}
end

return options
