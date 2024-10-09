local lspconfig = require('lspconfig')

-- C++ is handled by clangd_extensions

local lsps = {
    'bashls',
    'gopls',
    'pylsp',
    'rust_analyzer',
}

for _, lsp in ipairs(lsps) do
    local cmd = lspconfig[lsp].config_def.default_config.cmd[1]

    if vim.fn.executable(cmd) == 1 then
        lspconfig[lsp].setup({
            autostart = false,
        })
    end
end
