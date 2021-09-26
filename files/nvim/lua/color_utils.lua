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

function M.get_highlight_options(name)
    local raw = vim.api.nvim_exec('highlight ' .. name, true)
    local result = {}

    for k, v in string.gmatch(raw, '(%S+)=(%S+)') do
        result[k] = v
    end

    return result
end

return M
