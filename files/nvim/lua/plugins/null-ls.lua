null_ls = require('null-ls')

local sources = {
    null_ls.builtins.code_actions.gitsigns,
}

if vim.fn.executable('clang-format') == 1 then
    table.insert(sources, null_ls.builtins.formatting.clang_format)
end

if vim.fn.executable('cmake-format') == 1 then
    table.insert(sources, null_ls.builtins.formatting.cmake_format)
end

if vim.fn.executable('shellcheck') == 1 then
    table.insert(sources, null_ls.builtins.diagnostics.shellcheck)
    table.insert(sources, null_ls.builtins.code_actions.shellcheck)
end

if vim.fn.executable('yamllint') == 1 then
    table.insert(sources, null_ls.builtins.diagnostics.yamllint)
end

null_ls.setup({
    sources = sources,
})
