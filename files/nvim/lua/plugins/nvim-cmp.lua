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
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- Recommended key bindings from README
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        [autocomplete_key] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = "crates" },
    },
}
