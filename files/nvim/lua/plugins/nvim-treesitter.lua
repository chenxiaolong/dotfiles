require 'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1377
        disable = {'yaml'},
    },
    playground = {
        enable = true,
    },
}

local bindings = {
    th = 'TSHighlightCapturesUnderCursor',
    tp = 'TSPlaygroundToggle',
}

for k, v in pairs(bindings) do
    vim.api.nvim_set_keymap(
        'n',
        '<leader>' .. k,
        '<cmd>' .. v .. '<cr>',
        {noremap = true}
    )
end
