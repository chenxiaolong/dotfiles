local builtin = require('telescope.builtin')

local bindings = {
    -- General
    fb = builtin.buffers,
    fc = builtin.commands,
    fC = builtin.command_history,
    fd = builtin.diagnostics,
    fg = builtin.live_grep,
    fh = builtin.help_tags,
    fs = builtin.search_history,
    -- Files
    fff = builtin.find_files,
    ffo = builtin.oldfiles,
    fft = builtin.filetypes,
    -- Treesitter
    ft = builtin.treesitter,
    -- LSP
    fla = vim.lsp.buf.code_action,
    fld = builtin.lsp_definitions,
    fli = builtin.lsp_implementations,
    flr = builtin.lsp_references,
    flt = builtin.lsp_type_definitions,
}


for k, v in pairs(bindings) do
    vim.keymap.set('n', '<leader>' .. k, v)
end
