-- If I ever have to see "Press ENTER or type command to continue" due to a
-- failed treesitter parser installation again... A better way would be to use
-- vim.ui_attach() and watch for msg_show events, but that disables all of the
-- builtin message and cmdline handling.
if not _G.print_orig then
    _G.print_orig = _G.print
end
_G.print = function(...)
    local caller = debug.getinfo(2)

    if vim.endswith(caller.source, '/nvim-treesitter/install.lua') then
        local stringified = {}

        for _, arg in ipairs({ ... }) do
            table.insert(stringified, tostring(arg))
        end

        vim.notify(table.concat(stringified, ' '), vim.log.levels.INFO)
    else
        _G.print_orig(...)
    end
end

require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.keymap.set('n', '<leader>ti', '<cmd>Inspect<cr>', { desc = 'Inspect item' })
vim.keymap.set('n', '<leader>tt', '<cmd>InspectTree<cr>', { desc = 'Inspect tree' })
