require('trouble').setup({
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = false,
})

local bindings = {
    ['<leader>xx'] = 'TroubleToggle',
    ['<leader>xw'] = 'TroubleToggle workspace_diagnostics',
    ['<leader>xd'] = 'TroubleToggle document_diagnostics',
    ['<leader>xq'] = 'TroubleToggle quickfix',
    ['<leader>xl'] = 'TroubleToggle loclist',
    ['gR']         = 'TroubleToggle lsp_references',
}

for k, v in pairs(bindings) do
    vim.keymap.set(
        'n',
        k,
        '<cmd>' .. v .. '<cr>'
    )
end
