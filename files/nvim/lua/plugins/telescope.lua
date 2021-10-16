local bindings = {
    -- General
    fb = 'buffers',
    fc = 'commands',
    fC = 'command_history',
    fg = 'live_grep',
    fh = 'help_tags',
    fs = 'search_history',
    -- Files
    fff = 'find_files',
    ffo = 'oldfiles',
    fft = 'filetypes',
    -- Treesitter
    ft = 'treesitter',
    -- LSP
    fla = 'lsp_code_actions',
    fld = 'lsp_definitions',
    fli = 'lsp_implementations',
    flo = 'lsp_document_diagnostics',
    flr = 'lsp_references',
    flt = 'lsp_type_definitions',
}

for k, v in pairs(bindings) do
    vim.api.nvim_set_keymap(
        'n',
        '<leader>' .. k,
        '<cmd>lua require("telescope.builtin").' .. v .. '()<cr>',
        {noremap = true}
    )
end
