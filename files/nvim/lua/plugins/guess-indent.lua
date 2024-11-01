local guess_indent = require('guess-indent')

local opts = {
    on_tab_options = {
        -- Make the tab key create tabstop-sized indentation.
        shiftwidth = 0
    }
}

require('guess-indent').setup(vim.tbl_deep_extend(
    'force',
    require('guess-indent.config').values,
    opts
))
