local vi_mode_utils = require('feline.providers.vi_mode')
local colorscheme = vim.api.nvim_exec('colorscheme', true)
local theme = require('colorscheme').colorschemes[string.sub(colorscheme, 8)]

local colors = {
    bg = '#2d2d2d',
    fg = theme.base05,
    cyan = theme.base0C,
    green = theme.base0B,
    light_blue = theme.base0D,
    light_gray = theme.base03,
    orange = theme.base09,
    purple = theme.base0E,
    red = theme.base08,
    white = theme.base07,
    yellow = theme.base0A,
}

local vi_mode_colors = {
    NORMAL = colors.green,
    OP = colors.green,
    INSERT = colors.yellow,
    VISUAL = colors.purple,
    LINES = colors.purple,
    BLOCK = colors.purple,
    REPLACE = colors.cyan,
    ['V-REPLACE'] = colors.cyan,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.red,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.white,
}

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
                    fg = colors.light_blue,
                },
            },
            {
                provider = 'git_branch',
                icon = ' ',
                left_sep = ' ',
                hl = {
                    fg = colors.purple,
                },
            },
            {
                provider = 'git_diff_added',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = colors.green,
                }
            },
            {
                provider = 'git_diff_changed',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = colors.orange,
                }
            },
            {
                provider = 'git_diff_removed',
                icon = '',
                left_sep = ' ',
                hl = {
                    fg = colors.red,
                }
            },
        },
        {
            {
                provider = 'lsp_client_names',
                icon = '',
                right_sep = ' ',
                hl = {
                    fg = colors.yellow,
                },
            },
            {
                provider = 'file_format',
                right_sep = ' ',
                hl = {
                    fg = colors.light_blue,
                },
            },
            {
                provider = 'file_encoding',
                right_sep = ' ',
                hl = {
                    fg = colors.green,
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
                    fg = colors.purple,
                },
            },
            {
                provider = 'position',
                right_sep = ' ',
                hl = {
                    fg = colors.cyan,
                },
            },
            {
                provider = 'line_percentage',
                right_sep = ' ',
                hl = {
                    fg = colors.cyan,
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

require('feline').setup {
    colors = {
        bg = colors.bg,
        fg = colors.fg,
    },
    components = components,
    vi_mode_colors = vi_mode_colors,
}
