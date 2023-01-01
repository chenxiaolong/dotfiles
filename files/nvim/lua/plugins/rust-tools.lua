if vim.fn.executable('rust-analyzer') == 1 then
    require('rust-tools').setup({})
end
