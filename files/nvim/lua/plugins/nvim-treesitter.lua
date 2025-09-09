-- Kernel 6.1 on the Google Pixel devices has a bug where it kernel panics from
-- a corrupted canary value when the device runs out of memory. Avoid using too
-- much memory by limiting the concurrency.
local max_jobs = nil
if not not os.getenv('ANDROID_ROOT') then
    max_jobs = 2
end

require('nvim-treesitter').install({ 'all' }, { max_jobs = max_jobs })

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
      -- The function fails if there is no treesitter parser available for the
      -- file type.
      pcall(vim.treesitter.start)
  end,
})

vim.bo.indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.keymap.set('n', '<leader>ti', '<cmd>Inspect<cr>', { desc = 'Inspect item' })
vim.keymap.set('n', '<leader>tt', '<cmd>InspectTree<cr>', { desc = 'Inspect tree' })
