local lspconfig = require('lspconfig')

-- C++ is handled by clangd_extensions

if vim.fn.executable('bash-language-server') == 1 then
    lspconfig.bashls.setup({
        autostart = false,
    })
end
if vim.fn.executable('gopls') == 1 then
    lspconfig.gopls.setup({
        autostart = false,
    })
end
if vim.fn.executable('pylsp') == 1 then
    lspconfig.pylsp.setup({
        autostart = false,
    })
end
if vim.fn.executable('rust-analyzer') == 1 then
    lspconfig.rust_analyzer.setup({
        autostart = false,
    })
end
