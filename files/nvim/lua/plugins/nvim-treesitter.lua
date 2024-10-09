require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
    },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

local bindings = {
    th = 'TSHighlightCapturesUnderCursor',
    tp = 'TSPlaygroundToggle',
}

for k, v in pairs(bindings) do
    vim.keymap.set(
        'n',
        '<leader>' .. k,
        '<cmd>' .. v .. '<cr>'
    )
end
