local base16_palette = require('utils.base16_palette')

local theme = {
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
}

local mode_names = {
    n = 'NORMAL',
    v = 'VISUAL',
    V = 'V-LINES',
    ['\22'] = 'V-BLOCK',
    s = 'SELECT',
    S = 'S-LINE',
    ['\19'] = 'S-BLOCK',
    i = 'INSERT',
    R = 'REPLACE',
    c = 'COMMAND',
    r = 'ENTER',
    ['!'] = 'SHELL',
    t = 'TERM',
}
local mode_colors = {
    n = theme.green,
    v = theme.purple,
    V = theme.purple,
    ['\22'] = theme.purple,
    s = theme.orange,
    S = theme.orange,
    ['\19'] = theme.orange,
    i = theme.yellow,
    R = theme.cyan,
    c = theme.red,
    r = theme.cyan,
    ['!'] = theme.green,
    t = theme.green,
}

local diff_prefix = {
    added = '+',
    changed = '~',
    removed = '-',
}
local diff_colors = {
    added = theme.green,
    changed = theme.orange,
    removed = theme.red,
}

local priority_mode = 1
local priority_location = 2
local priority_name = 3
local priority_file_info = 4
local priority_git = 5

local components = {
    active = {
        {
            {
                ' ',
                function()
                    return {
                        str = mode_names[vim.fn.mode()],
                        hl = {
                            fg = mode_colors[vim.fn.mode()],
                        },
                    }
                end,
                priority = priority_mode,
            },
            {
                ' ',
                function()
                    local filename = vim.api.nvim_buf_get_name(0)
                    if filename == '' then
                        filename = '[No Name]'
                    else
                        filename = vim.fn.fnamemodify(filename, ':t')
                    end

                    local modifiers = ''

                    if vim.bo.modified then
                        modifiers = modifiers .. '[*]'
                    end
                    if vim.bo.readonly then
                        modifiers = modifiers .. '[!]'
                    end

                    if modifiers ~= '' then
                        filename = filename .. ' ' .. modifiers
                    end

                    return {
                        str = filename:gsub('%%', '%%%%'),
                        hl = {
                            fg = theme.light_blue,
                        },
                    }
                end,
                priority = priority_name,
            },
            {
                ' ',
                function()
                    local head = vim.b.gitsigns_head
                    local str

                    if head then
                        str = ' ' .. head
                    else
                        str = ''
                    end

                    return {
                        str = str,
                        hl = {
                            fg = theme.purple,
                        },
                    }
                end,
                priority = priority_git,
            },
            function()
                local group = {}

                local status = vim.b.gitsigns_status_dict

                if status then
                    for _, type in ipairs({'added', 'changed', 'removed'}) do
                        if status[type] and status[type] > 0 then
                            group[#group + 1] = ' '
                            group[#group + 1] = {
                                str = string.format(
                                    '%s%d',
                                    diff_prefix[type],
                                    status[type]
                                ),
                                hl = {
                                    fg = diff_colors[type],
                                },
                            }
                        end
                    end
                end

                group.priority = priority_git

                return group
            end,
        },
        {
            {
                function()
                    local clients = {}

                    for _, client in pairs(vim.lsp.get_clients { bufnr = 0 }) do
                        clients[#clients + 1] = client.name
                    end

                    return {
                        str = table.concat(clients, ' '),
                        hl = {
                            fg = theme.yellow,
                        },
                    }
                end,
                ' ',
                priority = priority_file_info,
            },
            {
                function()
                    return {
                        str = vim.bo.fileformat,
                        hl = {
                            fg = theme.light_blue,
                        },
                    }
                end,
                ' ',
                priority = priority_file_info,
            },
            {
                function()
                    local str

                    if vim.bo.fileencoding ~= '' then
                        str = vim.bo.fileencoding
                    else
                        str = vim.o.encoding
                    end

                    return {
                        str = str,
                        hl = {
                            fg = theme.green,
                        },
                    }
                end,
                ' ',
                priority = priority_file_info,
            },
            {
                function()
                    return {
                        str = vim.bo.filetype,
                        hl = {
                            fg = theme.purple,
                        },
                    }
                end,
                ' ',
                priority = priority_file_info,
            },
            {
                {
                    str = '%l:%c',
                    hl = {
                        fg = theme.cyan,
                    },
                },
                ' ',
                priority = priority_location,
            },
            {
                function()
                    local line = vim.api.nvim_win_get_cursor(0)[1]
                    local lines = vim.api.nvim_buf_line_count(0)
                    local str

                    if lines == 1 then
                        str = 'All'
                    elseif line == 1 then
                        str = 'Top'
                    elseif line == lines then
                        str = 'Bot'
                    else
                        local percentage = math.floor(line / lines * 100 + 0.5)
                        str = string.format('%d%%%%', percentage)
                    end

                    return {
                        str = str,
                        hl = {
                            fg = theme.cyan,
                        },
                    }
                end,
                ' ',
                priority = priority_location,
            },
        },
    },
    inactive = {
        {},
        {},
    },
}

-- Inactive components are the same, except there's no mode component.
for section_index, section in ipairs(components.active) do
    for component_index, component in ipairs(section) do
        if not (section_index == 1 and component_index == 1) then
            table.insert(components.inactive[section_index], component)
        end
    end
end

local statusline = require('utils.statusline')

statusline.setup(components)

local group = vim.api.nvim_create_augroup('Statusline', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
    callback = statusline.clear_highlights,
    group = group,
})

vim.api.nvim_create_autocmd('User', {
    pattern = {'GitSignsUpdate', 'GitSignsChanged'},
    callback = vim.schedule_wrap(function()
        vim.cmd('redrawstatus')
    end),
    group = group,
})
