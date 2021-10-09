local wezterm = require('wezterm')
local base16 = require('base16')

local M = {
    constants = {
        text_bg_active = '#393939',
        text_bg_inactive = '#2d2d2d',
        text_fg_active = '#cccccc',
        text_fg_inactive = '#999999',
        prefix_bg_active = '#2d2d2d',
        prefix_bg_inactive = '#262626',
        prefix_fg_active = '#f99157',
        prefix_fg_inactive = '#6699cc',
    },
}

M.tab_bar = {
    background = base16.ansi[1],
    -- Colors unused, except for new_tab{,_hover}, but cannot be removed without
    -- cause deserialization errors
    active_tab = {
        bg_color = M.constants.text_bg_active,
        fg_color = M.constants.text_fg_active,
    },
    inactive_tab = {
        bg_color = M.constants.text_bg_inactive,
        fg_color = M.constants.text_fg_inactive,
        intensity = 'Half',
    },
    inactive_tab_hover = {
        bg_color = M.constants.text_bg_active,
        fg_color = M.constants.text_fg_active,
        intensity = 'Bold',
    },
    new_tab = {
        bg_color = M.constants.text_bg_inactive,
        fg_color = M.constants.text_fg_inactive,
        intensity = 'Half',
    },
    new_tab_hover = {
        bg_color = M.constants.text_bg_active,
        fg_color = M.constants.text_fg_active,
        intensity = 'Bold',
    },
}

function M.format_tab_title(tab, tabs, panes, config, hover, max_width)
    local index_bg
    local index_fg
    local title_bg
    local title_fg

    if tab.is_active then
        index_bg = M.constants.prefix_bg_active
        index_fg = M.constants.prefix_fg_active
        title_bg = M.constants.text_bg_active
        title_fg = M.constants.text_fg_active
    else
        index_bg = M.constants.prefix_bg_inactive
        index_fg = M.constants.prefix_fg_inactive
        title_bg = M.constants.text_bg_inactive
        title_fg = M.constants.text_fg_inactive
    end

    local result = {}

    local ellipsis = utf8.char(0x2026)
    local ellipsis_len = wezterm.column_width(ellipsis)

    local prefix = tostring(tab.tab_index)
    -- Padding around index + padding around title + tab spacer
    local max_title = max_width - 5 - wezterm.column_width(prefix)
    local title

    if max_title >= ellipsis_len then
        -- Index
        table.insert(result, {Background = {Color = index_bg}})
        table.insert(result, {Foreground = {Color = index_fg}})
        table.insert(result, {Text = ' ' .. prefix .. ' '})

        title = wezterm.truncate_right(tab.active_pane.title, max_title)
        -- The truncate functions are grapheme width aware
        if title ~= tab.active_pane.title then
            title = wezterm.truncate_right(title, max_title - ellipsis_len) .. ellipsis
        end
    else
        title = ellipsis
    end

    table.insert(result, {Background = {Color = title_bg}})
    table.insert(result, {Foreground = {Color = title_fg}})
    table.insert(result, {Text = ' ' .. title .. ' '})

    -- Tab spacer
    table.insert(result, {Background = {Color = config.colors.background}})
    table.insert(result, {Text = ' '})

    return result
end

function M.update_right_status(window, pane)
    local time = wezterm.strftime('%H:%M')
    local date = wezterm.strftime('%Y-%m-%d')

    window:set_right_status(wezterm.format({
        {Attribute = {Intensity = 'Bold'}},
        {Background = {Color = M.constants.prefix_bg_active}},
        {Foreground = {Color = M.constants.prefix_fg_active}},
        {Text = ' ' .. time .. ' | '},
        {Foreground = {Color = M.constants.prefix_fg_inactive}},
        {Text = date .. ' '},
    }))
end

return M
