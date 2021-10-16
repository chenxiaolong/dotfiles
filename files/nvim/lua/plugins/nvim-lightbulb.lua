vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])

-- neovim 0.5 on Windows uses a fork of libuv 1.34.2 (at commit:
-- b899d12b0d56d217f31222da83f8c398355b69ef), which is missing
-- a fix to support surrogate pairs, preventing emojis from
-- displaying properly: https://github.com/libuv/libuv/pull/2971
if vim.fn.has('win32') then
    vim.fn.sign_define('LightBulbSign', { text = '?', texthl = 'LspDiagnosticsDefaultInformation' })
end
