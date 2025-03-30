-- Enable 24-bit colors
vim.opt.termguicolors = true

require('plugins')

-- Enable line numbering
vim.opt.number = true

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- 4 space indentation
vim.opt.shiftwidth = 4

-- Indent/dedent to nearest boundary
vim.opt.shiftround = true

-- Highlight trailing whitespace
vim.opt.list = true

-- Smart case for searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- http://www.johnhawthorn.com/2012/09/vi-escape-delays/
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

-- 80 character column indicator
vim.opt.colorcolumn = '81,101'

-- Show at least 4 lines of context when scrolling
vim.opt.scrolloff = 4

-- Prefer Unix line endings on Windows
if vim.fn.has('win32') then
    vim.opt.fileformats = {'unix', 'dos'}
end

-- Hide the default mode text (e.g. -- INSERT -- below the status line)
vim.opt.showmode = false

-- Use a global status line
vim.opt.laststatus = 3

-- Sane splitting behavior
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = 'screen'

-- Don't fold by default
vim.opt.foldlevelstart = 99

-- Fold using treesitter unless the LSP supports it
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
        end
    end,
})

-- Don't select a completion item by default
vim.opt.completeopt = 'menuone,noselect'

-- Show border around floating windows
vim.opt.winborder = 'single'

-- Treat Jenkinsfiles as groovy code
vim.filetype.add({
    filename = {
        ['Jenkinsfile'] = 'groovy',
    },
})

-- Show yanked lines
vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function() vim.highlight.on_yank() end,
})

-- Show LSP errors on separate lines
vim.diagnostic.config({
    virtual_lines = true
})
