local M = {}

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
        result[name] = options
    end

    return result
end

function M.get_highlight_options(name)
    local raw = vim.api.nvim_exec('highlight ' .. name, true)
    local _, options = parse_highlight_line(raw)
    return options
end

return M
