local wezterm = require('wezterm')
local base16 = require('base16')

local M = {
    constants = {
        active = {
            text_bg = '#393939',
            text_fg = '#cccccc',
            prefix_bg = '#2d2d2d',
            prefix_fg = '#f99157',
        },
        inactive = {
            text_bg = '#2d2d2d',
            text_fg = '#999999',
            prefix_bg = '#262626',
            prefix_fg = '#6699cc',
        },
    },
}

M.tab_bar = {
    background = base16.ansi[1],
    -- The prefix colors are handled directly in format_tab_title
    active_tab = {
        bg_color = M.constants.active.text_bg,
        fg_color = M.constants.active.text_fg,
    },
    inactive_tab = {
        bg_color = M.constants.inactive.text_bg,
        fg_color = M.constants.inactive.text_fg,
        intensity = 'Half',
    },
    inactive_tab_hover = {
        bg_color = M.constants.active.text_bg,
        fg_color = M.constants.active.text_fg,
        intensity = 'Bold',
    },
    new_tab = {
        bg_color = M.constants.inactive.text_bg,
        fg_color = M.constants.inactive.text_fg,
        intensity = 'Half',
    },
    new_tab_hover = {
        bg_color = M.constants.active.text_bg,
        fg_color = M.constants.active.text_fg,
        intensity = 'Bold',
    },
}

function M.format_tab_title(tab, tabs, panes, config, hover, max_width)
    local colors
    local text_colors

    if tab.is_active then
        colors = M.constants.active
        text_colors = M.tab_bar.active_tab
    else
        colors = M.constants.inactive
        text_colors = M.tab_bar.inactive_tab
    end

    local result = {}

    local ellipsis = utf8.char(0x2026)
    local ellipsis_len = wezterm.column_width(ellipsis)

    local prefix = tostring(tab.tab_index + 1)
    -- Padding around index + padding around title + tab spacer
    local max_title = max_width - 5 - wezterm.column_width(prefix)
    local title

    if max_title >= ellipsis_len then
        -- Index
        table.insert(result, {Background = {Color = colors.prefix_bg}})
        table.insert(result, {Foreground = {Color = colors.prefix_fg}})
        table.insert(result, {Text = ' ' .. prefix .. ' '})

        title = wezterm.truncate_right(tab.active_pane.title, max_title)
        -- The truncate functions are grapheme width aware
        if title ~= tab.active_pane.title then
            title = wezterm.truncate_right(title, max_title - ellipsis_len) .. ellipsis
        end
    else
        title = ellipsis
    end

    table.insert(result, {Background = {Color = text_colors.bg_color}})
    table.insert(result, {Foreground = {Color = text_colors.fg_color}})
    table.insert(result, {Text = ' ' .. title .. ' '})

    -- Tab spacer
    table.insert(result, {Background = {Color = M.tab_bar.background}})
    table.insert(result, {Text = ' '})

    return result
end

function M.update_right_status(window, pane)
    local time = wezterm.strftime('%H:%M')
    local date = wezterm.strftime('%Y-%m-%d')

    window:set_right_status(wezterm.format({
        {Attribute = {Intensity = 'Bold'}},
        {Background = {Color = M.constants.active.prefix_bg}},
        {Foreground = {Color = M.constants.active.prefix_fg}},
        {Text = ' ' .. time .. ' | '},
        {Foreground = {Color = M.constants.inactive.prefix_fg}},
        {Text = date .. ' '},
    }))
end

return M
