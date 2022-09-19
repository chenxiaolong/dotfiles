local lspconfig = require('lspconfig')

-- C++ is handled by clangd_extensions
-- Rust is handled by rust-tools

if vim.fn.executable('bash-language-server') == 1 then
    lspconfig.bashls.setup({})
end
if vim.fn.executable('pylsp') == 1 then
    lspconfig.pylsp.setup({})
end
