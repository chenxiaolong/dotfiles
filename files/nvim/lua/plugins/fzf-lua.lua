local fzf_lua = require('fzf-lua')

local opts = {}
local function with_desc(desc)
    return vim.tbl_extend("force", opts, { desc = desc })
end

vim.keymap.set('n', '<leader>fa', fzf_lua.builtin, with_desc('fzf-lua builtins'))
vim.keymap.set('n', '<leader>fr', fzf_lua.resume, with_desc('Reopen last'))
-- General
vim.keymap.set('n', '<leader>fb', fzf_lua.buffers, with_desc('Buffers'))
vim.keymap.set('n', '<leader>fc', fzf_lua.commands, with_desc('Commands'))
vim.keymap.set('n', '<leader>fC', fzf_lua.command_history, with_desc('Command history'))
-- Files
vim.keymap.set('n', '<leader>fff', fzf_lua.files, with_desc('Files'))
vim.keymap.set('n', '<leader>ffo', fzf_lua.oldfiles, with_desc('Recent files'))
vim.keymap.set('n', '<leader>fft', fzf_lua.filetypes, with_desc('File types'))
-- LSP
vim.keymap.set('n', '<leader>fla', fzf_lua.lsp_code_actions, with_desc('Code actions'))
vim.keymap.set('n', '<leader>fld', fzf_lua.diagnostics_document, with_desc('Diagnostics'))
vim.keymap.set('n', '<leader>flD', fzf_lua.lsp_definitions, with_desc('Definitions'))
vim.keymap.set('n', '<leader>fle', fzf_lua.lsp_finder, with_desc('Everything'))
vim.keymap.set('n', '<leader>fli', fzf_lua.lsp_implementations, with_desc('Implementations'))
vim.keymap.set('n', '<leader>flr', fzf_lua.lsp_references, with_desc('References'))
vim.keymap.set('n', '<leader>fls', fzf_lua.lsp_document_symbols, with_desc('Symbols'))
vim.keymap.set('n', '<leader>flt', fzf_lua.lsp_typedefs, with_desc('Type definitions'))
--- Search
vim.keymap.set('n', '<leader>fsg', fzf_lua.live_grep_native, with_desc('Live grep'))
vim.keymap.set('n', '<leader>fsh', fzf_lua.search_history, with_desc('Search history'))
vim.keymap.set('n', '<leader>fsl', fzf_lua.lines, with_desc('Fuzzy lines'))
vim.keymap.set('v', '<leader>fss', fzf_lua.grep_visual, with_desc('Search selection'))

fzf_lua.register_ui_select()
