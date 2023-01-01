if vim.fn.executable('clangd') == 1 then
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- https://github.com/neovim/neovim/pull/16694
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
    capabilities.offsetEncoding = { 'utf-16' }

    require('clangd_extensions').setup({
        server = {
            capabilities = capabilities,
        },
    })
end
