local wezterm = require('wezterm')
local base16 = require('base16')
local tab_bar = require('tab_bar')

local colors = {
    ansi = base16.ansi,
    brights = base16.brights,
    indexed = base16.indexed,
    selection_bg = 'rgba(50% 50% 50% 50%)',
    selection_fg = 'none',
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

local options = {
    colors = colors,
    font = wezterm.font('Fira Code'),
    font_size = 9,
    warn_about_missing_glyphs = false,
    enable_kitty_keyboard = true,
    enable_scroll_bar = true,
    keys = {
        {
            mods = "CTRL|SHIFT",
            key = "e",
            action = wezterm.action({
                CloseCurrentPane = {
                    confirm = true,
                },
            }),
        },
        {
            mods = "CTRL|SHIFT",
            key = "Enter",
            action = wezterm.action({
                ShowLauncherArgs = {
                    flags = 'TABS|LAUNCH_MENU_ITEMS|DOMAINS|WORKSPACES',
                },
            }),
        },
        {
            mods = 'SHIFT',
            key = 'UpArrow',
            action = wezterm.action.ScrollToPrompt(-1),
        },
        {
            mods = 'SHIFT',
            key = 'DownArrow',
            action = wezterm.action.ScrollToPrompt(1),
        },
    },
    mouse_bindings = {
        -- Remove link opening behavior for default bindings
        {
            event = {
                Up = {
                    streak = 1,
                    button = 'Left',
                },
            },
            mods = 'NONE',
            action = wezterm.action.CompleteSelection('PrimarySelection'),
        },
        {
            event = {
                Up = {
                    streak = 1,
                    button = 'Left',
                },
            },
            mods = 'SHIFT',
            action = wezterm.action.CompleteSelection('PrimarySelection'),
        },
        -- Use control click to open links
        {
            event = {
                Up = {
                    streak = 1,
                    button = 'Left',
                },
            },
            mods = 'CTRL',
            action = wezterm.action.OpenLinkAtMouseCursor,
        },
        {
            event = {
                Down = {
                    streak = 1,
                    button = 'Left',
                },
            },
            mods = 'CTRL',
            action = wezterm.action.Nop,
        }
    },
    scrollback_lines = 50000,
    tab_max_width = 24,
    use_fancy_tab_bar = false,
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    options.default_prog = {'pwsh.exe'}
end

return options
