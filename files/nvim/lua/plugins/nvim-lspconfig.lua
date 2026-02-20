local lsps = {
    'bashls',
    'clangd',
    'gopls',
    'pylsp',
    'rust_analyzer',
}

for _, lsp in ipairs(lsps) do
    local lspconfig = require('lspconfig.configs.' .. lsp)
    local cmd = lspconfig.default_config.cmd[1]

    if vim.fn.executable(cmd) == 1 then
        vim.lsp.config(lsp, {
            autostart = false,
        })
    end
end
