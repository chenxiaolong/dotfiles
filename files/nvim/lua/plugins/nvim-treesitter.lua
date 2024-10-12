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

vim.keymap.set('n', '<leader>th', '<cmd>TSHighlightCapturesUnderCursor<cr>', { desc = "Highlight current captures" })
vim.keymap.set('n', '<leader>tp', '<cmd>TSPlaygroundToggle<cr>', { desc = "Toggle playground" })
