require('plugins')

-- Enable 24-bit colors
vim.opt.termguicolors = true

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
vim.opt.colorcolumn = '81'

-- Show at least 4 lines of context when scrolling
vim.opt.scrolloff = 4

-- Prefer Unix line endings on Windows
if vim.fn.has('win32') then
    vim.opt.fileformats = {'unix', 'dos'}
end

-- Hide the default mode text (e.g. -- INSERT -- below the status line)
vim.opt.showmode = false

-- Sane splitting behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Don't fold by default
vim.opt.foldlevelstart = 99

-- Treat Jenkinsfiles as groovy code
vim.cmd([[autocmd BufRead,BufNewFile Jenkinsfile setfiletype groovy]])

-- Show yanked lines
vim.cmd([[autocmd TextYankPost * lua vim.highlight.on_yank()]])
