local cmp = require('cmp')
local autocomplete_key

-- https://github.com/neovim/neovim/issues/13680
-- https://github.com/libuv/libuv/pull/2535
-- https://github.com/microsoft/terminal/issues/2865
-- NOTE: Requires corresponding Windows Terminal setting
if vim.fn.has('win32') then
    autocomplete_key = '<C-S-Insert>'
else
    autocomplete_key = '<C-Space>'
end

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        -- Recommended key bindings from README
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        [autocomplete_key] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
    },
    documentation = {
        border = {
            '┌', -- Top-left corner
            '─', -- Top edge
            '┐', -- Top-right corner
            '│', -- Right edge
            '┘', -- Bottom-right corner
            '─', -- Bottom edge
            '└', -- Bottom-left corner
            '│', -- Left edge
        },
    },
}
