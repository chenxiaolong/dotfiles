local M = {}

function M.multiply_color(color, ratio)
    local rgb = vim.api.nvim_get_color_by_name(color)
    if rgb == -1 then
        error('Invalid color: ' .. color)
    end

    local r = bit.rshift(rgb, 16)
    local g = bit.band(bit.rshift(rgb, 8), 0xff)
    local b = bit.band(rgb, 0xff)

    return string.format('#%02x%02x%02x', r * ratio, g * ratio, b * ratio)
end

function parse_highlight_line(line)
    local iter = vim.gsplit(line, '(%s+)')
    local name = iter()
    iter() -- 'xxx' color preview

    local options = {}

    for option in iter do
        local k, v = unpack(vim.split(option, '='))
        options[k] = v
    end

    return name, options
end

function M.get_all_highlight_options()
    local raw = vim.api.nvim_exec('highlight', true)
    local result = {}

    for line in vim.gsplit(raw, '[\r\n]') do
        local name, options = parse_highlight_line(line)
    end

    return result
end

function M.get_highlight_options(name)
    local raw = vim.api.nvim_exec('highlight ' .. name, true)
    local _, options = parse_highlight_line(raw)
    return options
end

return M
