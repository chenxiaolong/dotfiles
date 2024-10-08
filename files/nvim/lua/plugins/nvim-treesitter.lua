require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'all',
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    playground = {
        enable = true,
    },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

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
