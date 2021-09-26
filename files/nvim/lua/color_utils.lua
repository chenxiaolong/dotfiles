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

function parse_highlight_kv_pairs(line)
    local result = {}

    for k, v in line:gmatch('(%S+)=(%S+)') do
        result[k] = v
    end

    return result
end

function M.get_all_highlight_options()
    local raw = vim.api.nvim_exec('highlight', true)
    local result = {}

    for name, rest in raw:gmatch('(%S+)%s*([^\r\n]+)') do
        result[name] = parse_highlight_kv_pairs(rest)
    end

    return result
end

function M.get_highlight_options(name)
    local raw = vim.api.nvim_exec('highlight ' .. name, true)
    return parse_highlight_kv_pairs(raw)
end

return M
