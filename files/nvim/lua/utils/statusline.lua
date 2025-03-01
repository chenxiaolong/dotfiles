local M = {
    components = nil,
    highlights = {},
}

function M._get_highlight(options)
    if type(options) == 'string' then
        return options
    end

    local fg = options.fg or 'NONE'
    local bg = options.bg or 'NONE'
    local style = options.style or 'NONE'

    local fg_name = fg
    local bg_name = bg

    if fg_name:sub(1, 1) == '#' then
        fg_name = fg_name:sub(2)
    end
    if bg_name:sub(1, 1) == '#' then
        bg_name = bg_name:sub(2)
    end

    local name = string.format(
        'StatusLine_%s_%s_%s',
        fg_name,
        bg_name,
        string.gsub(style, ',', '_')
    )

    if not M.highlights[name] then
        vim.api.nvim_command(
            string.format(
                'highlight %s guifg=%s guibg=%s gui=%s',
                name,
                fg or 'NONE',
                bg or 'NONE',
                style or 'NONE'
            )
        )

        M.highlights[name] = true
    end

    return name
end

function M.clear_highlights()
    for name, _ in pairs(M.highlights) do
        vim.cmd('highlight clear ' .. name)
    end

    M.highlights = {}
end

local function get_expanded_width(str)
    return vim.api.nvim_eval_statusline(str, { maxwidth = 0 }).width
end

local function eval_group_item(item)
    if type(item) == 'function' then
        item = item()
    end

    if type(item) == 'string' then
        return { str = item }
    end

    return item
end

local function eval_group(group)
    if type(group) == 'function' then
        group = group()
    end

    local total_str = ''
    local total_width = 0

    for i, item in ipairs(group) do
        local evaled = eval_group_item(item)

        local item_hl = evaled.hl or {}
        local item_str = string.format(
            '%%#%s#%s',
            M._get_highlight(item_hl),
            evaled.str
        )
        local item_width = get_expanded_width(item_str)

        -- If any item in the group is empty, we omit the entire group.
        if item_width == 0 then
            total_str = ''
            total_width = 0
            break
        end

        total_str = total_str .. item_str
        total_width = total_width + item_width
    end

    return group, total_str, total_width
end

local function eval_group_or_log_error(group, type, i_section, i_group)
    local ok, evaled_group, str, width = pcall(eval_group, group)
    if not ok then
        vim.api.nvim_err_writeln(
            string.format(
                'Failed to evaluate type=%s, section=%d, group=%d: %s',
                type,
                i_section,
                i_group,
                -- Value of error().
                evaled_group
            )
        )

        if type(group) == 'function' then
            evaled_group = {}
        else
            evaled_group = group
        end
        str = ''
        width = 0
    end

    return evaled_group, str, width
end

local function is_always_inactive()
    return vim.bo.filetype == 'help'
end

local function eval_statusline(components)
    local max_width

    if vim.o.laststatus == 3 then
        max_width = vim.o.columns
    else
        max_width = vim.api.nvim_win_get_width(0)
    end

    local is_active = vim.api.nvim_get_current_win() == tonumber(vim.g.actual_curwin)
        and not is_always_inactive()
    local type

    if is_active then
        type = 'active'
    else
        type = 'inactive'
    end

    local sections = components[type]
    if not sections then
        return ''
    end

    local group_strs = {}
    local group_widths = {}
    local group_priorities = {}
    local total_width = 0

    for i_section, section in ipairs(sections) do
        if i_section > 1 then
            group_strs[#group_strs + 1] = '%='
            group_widths[#group_widths + 1] = 0
            group_priorities[#group_priorities + 1] = 0
        end

        for i_group, group in ipairs(section) do
            local group, group_str, group_width = eval_group_or_log_error(
                group,
                statusline_type,
                i_section,
                i_group
            )

            group_strs[#group_strs + 1] = group_str
            group_widths[#group_widths + 1] = group_width
            group_priorities[#group_priorities + 1] =
                group.priority or (#group_priorities + 1)

            total_width = total_width + group_width
        end
    end

    if total_width > max_width then
        local sorted_items = {}

        for i, priority in ipairs(group_priorities) do
            sorted_items[i] = {
                priority = priority,
                index = i,
            }
        end

        -- Lower numbers have more significance.
        table.sort(sorted_items, function(a, b)
            if a.priority == b.priority then
                return a.index > b.index
            else
                return a.priority > b.priority
            end
        end)

        for _, item in ipairs(sorted_items) do
            total_width = total_width - group_widths[item.index]
            group_strs[item.index] = ''
            group_widths[item.index] = 0

            if total_width <= max_width then
                break
            end
        end
    end

    return table.concat(group_strs)
end

function M.render()
    return eval_statusline(M.components)
end

function M.setup(components)
    M.components = components

    vim.g.qf_disable_statusline = true
    vim.o.statusline = "%{%v:lua.require'utils.statusline'.render()%}"
end

return M
