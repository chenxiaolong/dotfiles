local vi_mode_utils = require('feline.providers.vi_mode')

local components = {
    active = {
        {
            {
                provider = vi_mode_utils.get_vim_mode,
                left_sep = ' ',
                hl = function()
                    return {
                        name = vi_mode_utils.get_mode_highlight_name(),
                        fg = vi_mode_utils.get_mode_color(),
                    }
                end,
            },
            {
                provider = {
                    name = 'file_info',
                    opts = {
                        colored_icon = false,
                        file_modified_icon = '[*]',
                        file_readonly_icon = '[!] ',
                    },
                },
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = 'light_blue',
                },
            },
            {
                provider = 'git_branch',
                icon = ' ',
                left_sep = ' ',
                hl = {
                    fg = 'purple',
                },
            },
            {
                provider = 'git_diff_added',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = 'green',
                }
            },
            {
                provider = 'git_diff_changed',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = 'orange',
                }
            },
            {
                provider = 'git_diff_removed',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = 'red',
                }
            },
        },
        {
            {
                provider = 'lsp_client_names',
                icon = '',
                right_sep = ' ',
                hl = {
                    fg = 'yellow',
                },
            },
            {
                provider = 'file_format',
                right_sep = ' ',
                hl = {
                    fg = 'light_blue',
                },
            },
            {
                provider = 'file_encoding',
                right_sep = ' ',
                hl = {
                    fg = 'green',
                },
            },
            {
                provider = {
                    name = 'file_type',
                    opts = {
                        case = 'lowercase'
                    },
                },
                right_sep = ' ',
                hl = {
                    fg = 'purple',
                },
            },
            {
                provider = 'position',
                right_sep = ' ',
                hl = {
                    fg = 'cyan',
                },
            },
            {
                provider = 'line_percentage',
                right_sep = ' ',
                hl = {
                    fg = 'cyan',
                },
            },
        },
    },
    inactive = {
        {},
        {},
    },
}

-- Inactive components are the same, except there's no vi_mode component
for section_index, section in ipairs(components.active) do
    for component_index, component in ipairs(section) do
        if not (section_index == 1 and component_index == 1) then
            table.insert(components.inactive[section_index], component)
        end
    end
end

local base16_palette = require('utils.base16_palette')

require('feline').setup {
    components = components,
    theme = {
        bg = base16_palette.base00,
        fg = base16_palette.base05,
        cyan = base16_palette.base0C,
        green = base16_palette.base0B,
        light_blue = base16_palette.base0D,
        light_gray = base16_palette.base03,
        orange = base16_palette.base09,
        purple = base16_palette.base0E,
        red = base16_palette.base08,
        white = base16_palette.base07,
        yellow = base16_palette.base0A,
    },
    vi_mode_colors = {
        NORMAL = 'green',
        OP = 'green',
        INSERT = 'yellow',
        VISUAL = 'purple',
        LINES = 'purple',
        BLOCK = 'purple',
        REPLACE = 'cyan',
        ['V-REPLACE'] = 'cyan',
        ENTER = 'cyan',
        MORE = 'cyan',
        SELECT = 'orange',
        COMMAND = 'red',
        SHELL = 'green',
        TERM = 'green',
        NONE = 'white',
    },
}
