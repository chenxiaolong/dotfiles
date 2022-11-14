local fzf_lua = require('fzf-lua')

local bindings = {
    -- General
    fb = fzf_lua.buffers,
    fc = fzf_lua.commands,
    fC = fzf_lua.command_history,
    fd = fzf_lua.diagnostics_document,
    fg = fzf_lua.live_grep,
    fh = fzf_lua.help_tags,
    fs = fzf_lua.search_history,
    -- Files
    fff = fzf_lua.files,
    ffo = fzf_lua.oldfiles,
    fft = fzf_lua.filetypes,
    -- LSP
    fla = vim.lsp.buf.code_action,
    fld = fzf_lua.lsp_definitions,
    fli = fzf_lua.lsp_implementations,
    flr = fzf_lua.lsp_references,
    flt = fzf_lua.lsp_typedefs,
}

for k, v in pairs(bindings) do
    vim.keymap.set('n', '<leader>' .. k, v)
end
